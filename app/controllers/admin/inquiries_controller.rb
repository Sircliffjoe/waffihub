class Admin::InquiriesController < Admin::BaseController
  def index
    @inquiries = Inquiry.all.order(created_at: :desc)
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])
    @inquiry.destroy
    redirect_to admin_inquiries_path, notice: "Inquiry was successfully deleted.", status: :see_other
  end
end
