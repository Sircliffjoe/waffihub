class EventsController < ApplicationController
  def index
    @page_title = "Events"
    @upcoming_events = Event.where('start_time >= ?', Time.current).order(start_time: :asc)
    @past_events = Event.where('start_time < ?', Time.current).order(start_time: :desc)
  end

  def show
    @event = Event.find(params[:id])
    @page_title = @event.title
  end
end
