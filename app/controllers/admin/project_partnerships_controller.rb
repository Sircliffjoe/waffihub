class Admin::ProjectPartnershipsController < Admin::BaseController
  def index
    @partnerships = ProjectPartnership.all.order(created_at: :desc)
    @page_title = "Project Partnerships"
  end

  def show
    @partnership = ProjectPartnership.find(params[:id])
    @page_title = "Partnership from #{@partnership.organization_name}"
  end

  def update
    @partnership = ProjectPartnership.find(params[:id])
    if @partnership.update(partnership_params)
      redirect_to admin_project_partnership_path(@partnership), notice: "Partnership status updated."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def destroy
    @partnership = ProjectPartnership.find(params[:id])
    @partnership.destroy
    redirect_to admin_project_partnerships_path, notice: "Partnership deleted."
  end

  private

  def partnership_params
    params.require(:project_partnership).permit(:status)
  end
end
