class Admin::PartnersController < Admin::BaseController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  def index
    @partners = Partner.all.order(position: :asc)
    @page_title = "Strategic Partners"
  end

  def new
    @partner = Partner.new
  end

  def create
    @partner = Partner.new(partner_params)
    if @partner.save
      redirect_to admin_partners_path, notice: "Partner was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partners_path, notice: "Partner was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @partner.destroy
    redirect_to admin_partners_path, notice: "Partner was successfully destroyed."
  end

  private

  def set_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(:name, :website_url, :position, :logo)
  end
end
