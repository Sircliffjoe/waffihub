class Admin::EnrollmentsController < Admin::BaseController
  def index
    @enrollments = Enrollment.all.includes(:user, :program).order(created_at: :desc)
  end

  def show
    @enrollment = Enrollment.find(params[:id])
  end
end
