module EventsHelper
  def render_created_at(create_at)
    create_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def render_event_content(event)
    if event.eventable.class == Todo
      event.eventable.title
    elsif event.eventable.class == Team
      event.eventable.name
    elsif event.eventable.class == Project
      event.eventable.name
    end
  end

end
