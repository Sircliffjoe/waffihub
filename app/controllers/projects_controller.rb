class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :apply, :submit_application, :partner, :submit_partnership]

  def index
    @page_title = "Our Work & Impact"
    @projects = Project.all.order(created_at: :desc)
  end

  def show
    @page_title = @project.name
  end

  def apply
    @application = @project.project_applications.build
  end

  def submit_application
    @application = @project.project_applications.build(application_params)
    @application.status = "pending"

    if @application.save
      redirect_to project_path(@project), notice: "Thank you! Your application for #{@project.name} has been received."
    else
      render :apply, status: :unprocessable_entity
    end
  end

  def partner
    @partnership = @project.project_partnerships.build
  end

  def submit_partnership
    @partnership = @project.project_partnerships.build(partnership_params)
    @partnership.status = "pending"

    if @partnership.save
      redirect_to project_path(@project), notice: "Thank you for your interest! We will contact you shortly regarding partnership for #{@project.name}."
    else
      render :partner, status: :unprocessable_entity
    end
  end

  private

  def set_project
    @project = Project.find_by!(slug: params[:id])
  end

  def application_params
    params.require(:project_application).permit(:first_name, :last_name, :email, :phone, :address, :background, :reason, :age_group, :marital_status, :course_track)
  end

  def partnership_params
    params.require(:project_partnership).permit(:organization_name, :contact_person, :email, :phone, :partnership_type, :message)
  end
end
