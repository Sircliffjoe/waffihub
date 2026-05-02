class Admin::ProjectApplicationsController < Admin::BaseController
  def index
    @applications = ProjectApplication.all.order(created_at: :desc)
    @page_title = "Project Applications"
  end

  def show
    @application = ProjectApplication.find(params[:id])
    @page_title = "Application from #{@application.name}"
  end

  def update
    @application = ProjectApplication.find(params[:id])
    if @application.update(application_params)
      redirect_to admin_project_application_path(@application), notice: "Application status updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @application = ProjectApplication.find(params[:id])
    @application.destroy
    redirect_to admin_project_applications_path, notice: "Application deleted."
  end

  private

  def application_params
    params.require(:project_application).permit(:status)
  end
end
