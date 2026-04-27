class Admin::PartnershipsController < Admin::BaseController
  before_action :set_partnership, only: [ :show, :edit, :update, :destroy ]

  def index
    @partnerships = Partnership.all.order(:name)
  end

  def show
  end

  def new
    @partnership = Partnership.new
  end

  def edit
  end

  def create
    @partnership = Partnership.new(partnership_params)
    if @partnership.save
      redirect_to admin_partnerships_path, notice: "Partnership was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @partnership.update(partnership_params)
      redirect_to admin_partnerships_path, notice: "Partnership was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @partnership.destroy
    redirect_to admin_partnerships_path, notice: "Partnership was successfully destroyed.", status: :see_other
  end

  private

  def set_partnership
    @partnership = Partnership.find(params[:id])
  end

  def partnership_params
    params.require(:partnership).permit(:name, :link, :description, :logo)
  end
end
