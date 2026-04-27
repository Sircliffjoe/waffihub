class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [ :show, :edit, :update, :destroy ]

  def index
    @projects = Project.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to admin_project_path(@project), notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to admin_project_path(@project), notice: "Project was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to admin_projects_path, notice: "Project was successfully destroyed.", status: :see_other
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :client, :problem, :solution, :outcome, images: [])
  end
end
