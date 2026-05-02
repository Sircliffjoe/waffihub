class PagesController < ApplicationController
  def home
    @page_title = "Welcome"
    @featured_programs = Program.limit(3).order(created_at: :desc)
    @featured_services = Service.limit(3)
    @latest_posts = Post.limit(3).order(published_at: :desc)
    @plans = Plan.all.order(price: :asc)
    @partners = Partner.all.order(position: :asc)
  end

  def about
    @page_title = "About Our Hub"
    @team_members = TeamMember.all
    @partners = Partner.all.order(position: :asc)
  end

  def contact
    @page_title = "Contact Us"
    @inquiry = Inquiry.new(subject: params[:subject])
  end
end
