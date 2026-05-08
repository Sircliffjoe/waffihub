class PaymentsController < ApplicationController
  # No login required for checkout anymore
  
  def new
    if params[:program_id]
      @program = Program.find(params[:program_id])
      @payment = Payment.new(program: @program, amount: @program.price)
    elsif params[:plan_id]
      @plan = Plan.find(params[:plan_id])
      @payment = Payment.new(plan: @plan, amount: @plan.price)
    else
      redirect_to root_path, alert: "No program or plan selected."
    end
    
    # Pre-fill if logged in
    if user_signed_in?
      @payment.email = current_user.email
      # You could add first_name/last_name to User model later if needed
    end
  end

  def create
    payment_params = params.require(:payment).permit(:program_id, :plan_id, :first_name, :last_name, :email, :phone, :address)
    
    if payment_params[:program_id].present?
      @program = Program.find(payment_params[:program_id])
      amount = @program.price
    elsif payment_params[:plan_id].present?
      @plan = Plan.find(payment_params[:plan_id])
      amount = @plan.price
    end

    @payment = Payment.new(payment_params)
    @payment.user = current_user if user_signed_in?
    @payment.amount = amount
    @payment.status = "pending"
    @payment.transaction_reference = "WP-#{SecureRandom.hex(8).upcase}"

    if @payment.save
      paystack = ::PaystackService.new
      result = paystack.initialize_transaction(
        email: @payment.email,
        amount: @payment.amount,
        reference: @payment.transaction_reference,
        callback_url: callback_payments_url
      )

      if result[:success]
        redirect_to result[:authorization_url], allow_other_host: true
      else
        @payment.update(status: "failed")
        redirect_to root_path, alert: "Error initializing payment: #{result[:error]}"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def callback
    reference = params[:reference]
    @payment = Payment.find_by(transaction_reference: reference)

    if @payment
      paystack = ::PaystackService.new
      result = paystack.verify_transaction(reference)

      if result[:success]
        @payment.update(status: "success", paystack_reference: result[:data]['reference'])
        
        guest_data = {
          first_name: @payment.first_name,
          last_name: @payment.last_name,
          email: @payment.email,
          phone: @payment.phone,
          address: @payment.address,
          user: @payment.user
        }

        if @payment.program
          Enrollment.find_or_create_by!(program: @payment.program, email: @payment.email) do |e|
            e.assign_attributes(guest_data)
          end
          redirect_to program_path(@payment.program), notice: "Payment successful! Your enrollment in #{@payment.program.title} is confirmed."
        elsif @payment.plan
          Booking.find_or_create_by!(plan: @payment.plan, email: @payment.email) do |b|
            b.assign_attributes(guest_data)
            b.status = "active"
          end
          redirect_to root_path, notice: "Payment successful! Your booking for #{@payment.plan.name} is now active."
        end
      else
        @payment.update(status: "failed")
        redirect_to root_path, alert: "Payment verification failed: #{result[:error]}"
      end
    else
      redirect_to root_path, alert: "Payment record not found."
    end
  end
end
