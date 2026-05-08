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
    # Redirect directly to guest checkout
    redirect_to new_payment_path(program_id: @program.id)
  end

  private

  def set_program
    @program = Program.find(params[:id])
  end
end
