class Admin::PlansController < Admin::BaseController
  before_action :set_plan, only: [:edit, :update, :destroy]

  def index
    @plans = Plan.all.order(price: :asc)
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.features = params[:plan][:features_text].split("\n").map(&:strip).reject(&:empty?) if params[:plan][:features_text].present?

    if @plan.save
      redirect_to admin_plans_path, notice: 'Plan was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @plan.assign_attributes(plan_params)
    @plan.features = params[:plan][:features_text].split("\n").map(&:strip).reject(&:empty?) if params[:plan][:features_text].present?

    if @plan.save
      redirect_to admin_plans_path, notice: 'Plan was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plan.destroy
    redirect_to admin_plans_path, notice: 'Plan was successfully destroyed.', status: :see_other
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :price, :interval, :highlight)
  end
end
