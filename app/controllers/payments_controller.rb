class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @program = Program.find(params[:program_id])
    @payment = Payment.new(program: @program, user: current_user, amount: @program.price)
  end

  def create
    @program = Program.find(params[:payment][:program_id])
    @payment = current_user.payments.build(
      program: @program,
      amount: @program.price,
      status: "pending",
      transaction_reference: "WP-#{SecureRandom.hex(8).upcase}"
    )

    if @payment.save
      # Initialize Paystack Payment
      begin
        # In a real app, you'd use the Paystack gem or direct API call
        # Here we'll simulate the initiation and redirect to a mock/success page
        # for the sake of the demo, but I'll add the real structure.

        # response = PaystackTransactions.initialize_transaction(
        #   email: current_user.email,
        #   amount: (@payment.amount * 100).to_i, # Paystack expects Kobo
        #   reference: @payment.transaction_reference,
        #   callback_url: callback_payments_url
        # )

        # redirect_to response['data']['authorization_url'], allow_other_host: true

        # FOR SIMULATION:
        redirect_to callback_payments_path(reference: @payment.transaction_reference)
      rescue => e
        @payment.update(status: "failed")
        redirect_to program_path(@program), alert: "Error initializing payment: #{e.message}"
      end
    else
      redirect_to program_path(@program), alert: "Failed to create payment record."
    end
  end

  def callback
    reference = params[:reference]
    @payment = Payment.find_by(transaction_reference: reference)

    if @payment
      # Verify with Paystack
      # response = PaystackTransactions.verify_transaction(reference)
      # if response['data']['status'] == 'success'

      # SIMULATED SUCCESS:
      @payment.update(status: "success")

      # Link enrollment or verify it exists
      enrollment = current_user.enrollments.find_or_create_by(program: @payment.program)

      redirect_to program_path(@payment.program), notice: "Payment successful! You are now enrolled in #{@payment.program.title}."
    else
      redirect_to root_path, alert: "Payment record not found."
    end
  end
end
