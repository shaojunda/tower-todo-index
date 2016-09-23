class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @team = Team.find(params[:team_id])
    @project = @team
    @project_permissions = current_user.project_permissions.select("project_id")
    @events = @team.events.where( ownerable_id: @project_permissions ).recent.limit(50)
    @group_events = @events.includes(:ownerable, :creator, :eventable).group_by{|e| e.created_at.to_date}
    @events_size = @events.size
    session.delete(:days)
    session.delete(:owners)
  end

end
