class PaystackService
  def initialize
    @paystack = Paystack.new(ENV['PAYSTACK_PUBLIC_KEY'], ENV['PAYSTACK_SECRET_KEY'])
  end

  def initialize_transaction(email:, amount:, reference:, callback_url:)
    transactions = PaystackTransactions.new(@paystack)
    begin
      response = transactions.initializeTransaction(
        email: email,
        amount: (amount * 100).to_i, # Paystack expects amount in kobo
        reference: reference,
        callback_url: callback_url
      )
      return { success: true, authorization_url: response['data']['authorization_url'] }
    rescue => e
      return { success: false, error: e.message }
    end
  end

  def verify_transaction(reference)
    transactions = PaystackTransactions.new(@paystack)
    begin
      response = transactions.verifyTransaction(reference)
      if response['status'] && response['data']['status'] == 'success'
        return { success: true, data: response['data'] }
      else
        return { success: false, error: "Transaction not successful" }
      end
    rescue => e
      return { success: false, error: e.message }
    end
  end
end
