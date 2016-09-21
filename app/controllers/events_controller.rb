class EventsController < ApplicationController
  # before_action :authenticate_user!
  before_action :get_current_page

  def index
    @events = Event.order("created_at desc").limit(10)
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
    session.delete(:days)
    session.delete(:owners)
  end

  def get_more_event
    @events = Event.offset(10 * @current_page.to_i).order("created_at desc").limit(10)
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
  end

  protected

  def get_current_page
    @current_page = params[:current_page]
    if @current_page.blank?
      @current_page = 1
    end
  end


end
