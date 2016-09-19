module EventsHelper
  def render_created_at(create_at)
    create_at.strftime("%Y-%m-%d %H:%M:%S")
  end

  def render_event_content(event)
    if event.eventable.class == Todo
      link_to event.eventable.title, "#"
    elsif event.eventable.class == Team
      link_to event.eventable.name, "#"
    elsif event.eventable.class == Project
      link_to event.eventable.name, "#"
    end
  end

  def render_event_action(event)
    event_action = ""
    event_action_extend = ""
    case event.action
    when "create_team"
      event_action = "创建了团队："
    when "create_project"
      event_action = "创建了项目："
    when "create_todo"
      event_action = "创建了任务："
    when "executor_assign_todo"

    end

    if event.eventable.class == Todo && event.eventable.assignment.present?
      if event.eventable.assignment.origin_executor.present? && event.eventable.assignment.new_executor.nil?
        event_action_extend = "为#{event.eventable.assignment.origin_executor.user_name}"
      elsif event.eventable.assignment.origin_executor.present? && event.eventable.assignment.new_executor.present?
        event_action_extend = "把#{event.eventable.assignment.origin_executor.user_name}的任务指派给了#{event.eventable.assignment.new_executor.user_name}"
      end
    end
    event_action_extend + event_action
  end

  def render_event_owner(event_owner)
    link_to event_owner, "#"
  end

end
