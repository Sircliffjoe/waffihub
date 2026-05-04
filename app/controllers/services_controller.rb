class ServicesController < ApplicationController
  def index
    @page_title = "Our Services"
    @services = Service.all
  end

  def show
    @service = Service.find(params[:id])
    @page_title = @service.title
    if @service.show_pricing || @service.category == "Co-working and Training"
      @plans = Plan.all.order(price: :asc)
    end
  end
end
