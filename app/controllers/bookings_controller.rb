class BookingsController < ApplicationController

  def create
    @plan = Plan.find(params[:plan_id])
    
    # We don't create a booking record yet, we'll do that after successful payment
    # or create a 'pending' one if preferred.
    # For now, let's redirect to payment.
    
    redirect_to new_payment_path(plan_id: @plan.id)
  end
end
