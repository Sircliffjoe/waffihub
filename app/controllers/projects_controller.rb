class ProjectsController < ApplicationController
  def index
    @page_title = "Our Work & Impact"
    @projects = Project.all.order(created_at: :desc)
  end

  def show
  end
end
