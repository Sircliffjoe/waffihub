class InquiriesController < ApplicationController
  def create
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.save
      redirect_to contact_path, notice: "Thank you for your message. We will get back to you shortly!"
    else
      redirect_to contact_path, alert: "There was an error sending your message. Please try again."
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :subject, :message)
  end
end
