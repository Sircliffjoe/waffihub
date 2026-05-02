class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    if params[:program_id]
      @program = Program.find(params[:program_id])
      @payment = Payment.new(program: @program, user: current_user, amount: @program.price)
    elsif params[:plan_id]
      @plan = Plan.find(params[:plan_id])
      @payment = Payment.new(plan: @plan, user: current_user, amount: @plan.price)
    else
      redirect_to root_path, alert: "No program or plan selected."
    end
  end

  def create
    if params[:payment][:program_id].present?
      @program = Program.find(params[:payment][:program_id])
      amount = @program.price
      plan_id = nil
      program_id = @program.id
    elsif params[:payment][:plan_id].present?
      @plan = Plan.find(params[:payment][:plan_id])
      amount = @plan.price
      plan_id = @plan.id
      program_id = nil
    end

    @payment = current_user.payments.build(
      program_id: program_id,
      plan_id: plan_id,
      amount: amount,
      status: "pending",
      transaction_reference: "WP-#{SecureRandom.hex(8).upcase}"
    )

    if @payment.save
      paystack = ::PaystackService.new
      result = paystack.initialize_transaction(
        email: current_user.email,
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
      redirect_to root_path, alert: "Failed to create payment record."
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
        
        if @payment.program
          # Create enrollment for program
          current_user.enrollments.find_or_create_by(program: @payment.program)
          redirect_to program_path(@payment.program), notice: "Payment successful! You are now enrolled in #{@payment.program.title}."
        elsif @payment.plan
          # Create booking for plan
          current_user.bookings.find_or_create_by(plan: @payment.plan, status: "active")
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
