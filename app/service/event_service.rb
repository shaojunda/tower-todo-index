class EventService
  def initialize(ownerable, eventable, creator, action)
    @ownerable = ownerable
    @eventable = eventable
    @creator = creator
    @action = action
  end

  def generate_event
    Event.create(ownerable: @ownerable, eventable: @eventable, creator: @creator, action: @action)
  end

end
