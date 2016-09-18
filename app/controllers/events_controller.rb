class EventsController < ApplicationController
  def index
    @events = Event.limit(50)
    @group_events = @events.group_by{|e| e.ownerable_type}
    @current_page = 1
  end

  def get_more_event
    @current_page = params[:current_page]
    @events = Event.limit(10).offset(50 * current_page)
    @group_events = @events.group_by{|e| e.ownerable_type}
  end
end
