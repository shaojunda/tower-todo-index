class EventsController < ApplicationController
  # before_action :authenticate_user!
  before_action :get_current_page

  def index
    @team = Team.find(params[:team_id])
    @events = @team.events.recent.limit(50)
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
    @events_size = @events.size
    session.delete(:days)
    session.delete(:owners)
  end

  def get_more_event
    @events = Event.offset(10 * @current_page.to_i).recent.limit(10)
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
