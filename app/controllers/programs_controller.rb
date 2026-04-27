class ProgramsController < ApplicationController
  before_action :set_program, only: [ :show, :enroll ]
  def index
    @page_title = "Training Programs"
    @programs = Program.all.order(created_at: :desc)
  end

  def show
    @page_title = @program.title
  end

  def enroll
    if !user_signed_in?
      store_location_for(:user, program_path(@program))
      redirect_to new_user_session_path, alert: "Please sign in or create an account to enroll."
      return
    end

    # Create enrollment if it doesn't exist
    @enrollment = current_user.enrollments.find_or_initialize_by(program: @program)

    if @enrollment.save
      # Redirect to payment initiation
      redirect_to new_payment_path(program_id: @program.id), notice: "Enrollment started. Please complete payment."
    else
      redirect_to program_path(@program), alert: "Failed to start enrollment. Please try again."
    end
  end

  private

  def set_program
    @program = Program.find(params[:id])
  end
end
