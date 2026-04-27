class PagesController < ApplicationController
  def home
    @page_title = "Welcome"
    @featured_programs = Program.limit(3).order(created_at: :desc)
    @featured_services = Service.limit(3)
    @latest_posts = Post.limit(3).order(published_at: :desc)
    @partners = Partnership.all
  end

  def about
    @page_title = "About Our Hub"
    @team_members = TeamMember.all
    @partners = Partnership.all
  end

  def impact
    @page_title = "Our Impact & Success Stories"
    @projects = Project.limit(6).order(created_at: :desc)
  end

  def contact
    @page_title = "Contact Us"
    @inquiry = Inquiry.new
  end
  def shebuilds
    @page_title = "SheBuilds Niger Delta"
  end
end
