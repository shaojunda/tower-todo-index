class EventsController < ApplicationController
  before_action :get_current_page

  def index
    @events = Event.limit(50).order("created_at desc")
    @group_events = @events.group_by{|e| e.ownerable_type}
  end

  def get_more_event
    @events = Event.limit(10).offset(50 * current_page)
    @group_events = @events.group_by{|e| e.ownerable_type}
  end

  protected

  def get_current_page
    @current_page = params[:current_page]
    if @current_page.blank?
      @current_page = 1
    end
  end


end
