class Admin::ProgramsController < Admin::BaseController
  before_action :set_program, only: [ :show, :edit, :update, :destroy ]

  def index
    @programs = Program.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @program = Program.new
  end

  def edit
  end

  def create
    @program = Program.new(program_params)
    if @program.save
      redirect_to admin_program_path(@program), notice: "Program was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @program.update(program_params)
      redirect_to admin_program_path(@program), notice: "Program was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @program.destroy
    redirect_to admin_programs_path, notice: "Program was successfully destroyed.", status: :see_other
  end

  private

  def set_program
    @program = Program.find(params[:id])
  end

  def program_params
    params.require(:program).permit(:title, :price, :duration, :mode, :instructor, :description, :main_image)
  end
end
