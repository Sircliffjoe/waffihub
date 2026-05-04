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
    permitted = params.require(:project).permit(
      :name, :client, :tagline, :hero_description, :main_image,
      :duration, :format, :reach, :cost, :slug,
      :about_description, :about_quote,
      :problem, :solution, :outcome,
      :curriculum_title, :curriculum_description,
      :timeline_title, :timeline_description,
      :partnership_title, :partnership_description,
      images: []
    )

    # Parse JSON fields from hidden inputs
    if params[:project][:tracks].present?
      permitted[:tracks] = JSON.parse(params[:project][:tracks]) rescue []
    end
    if params[:project][:timeline_steps].present?
      permitted[:timeline_steps] = JSON.parse(params[:project][:timeline_steps]) rescue []
    end
    if params[:project][:partnership_bullets].present?
      permitted[:partnership_bullets] = JSON.parse(params[:project][:partnership_bullets]) rescue []
    end

    permitted
  end
end
