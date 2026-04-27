class Admin::PaymentsController < Admin::BaseController
  def index
    @payments = Payment.all.includes(:user, :program).order(created_at: :desc)
  end

  def show
    @payment = Payment.find(params[:id])
  end
end
