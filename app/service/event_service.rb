class EventService
  def initialize(ownerable, eventable, creator, action, team)
    @ownerable = ownerable
    @eventable = eventable
    @creator = creator
    @action = action
    @team = team
  end

  def generate_event
    Event.create!(ownerable: @ownerable, eventable: @eventable, creator: @creator, action: @action, team: @team)
  end

end
