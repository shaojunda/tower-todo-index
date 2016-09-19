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

  def create_todo_with_executor(event)
    "为 #{event.eventable.assignment.origin_executor.user_name} 创建了任务："
  end

  def assign_executor_todo(event)
    if event.eventable.assignment.new_executor.present?
      "把 #{event.eventable.assignment.origin_executor.user_name} 的任务指派给 #{event.eventable.assignment.new_executor.user_name}："
    else
      "给 #{event.eventable.assignment.origin_executor.user_nam} 指派了任务："
    end
  end

  def assign_deadline_todo(event)
    origin_deadline = format_date_for_deadline(event.eventable.assignment.origin_deadline)
    if event.eventable.assignment.new_deadline.present?
      new_deadline = format_date_for_deadline(event.eventable.assignment.new_deadline)
      "将任务完成时间从 #{origin_deadline} 修改为 #{new_deadline}"
    else
      "将任务完成时间从 没有截止日 修改为 #{origin_deadline}"
    end
  end

  # 需要进一步细化 比如 本周五 下周五 今天 明天
  def format_date_for_deadline(deadline)
    if deadline.strftime("%Y").to_i < Time.now.year || deadline.strftime("%Y").to_i > Time.now.year
      deadline.strftime("%Y年%-m月%d日")
    else
      deadline.strftime("%-m月%d日")
    end
  end

  def render_event_action(event)
    event_action = ""
    case event.action
    when "create_team"
      event_action = "创建了团队："
    when "create_project"
      event_action = "创建了项目："
    when "create_todo"
      event_action = "创建了任务："
    when "create_todo_with_executor"
      event_action = create_todo_with_executor(event)
    when "assign_executor_todo"
      event_action = assign_executor_todo(event)
    when "finish_todo"
      event_action = "完成了任务："
    when "assign_deadline_todo"
      event_action = assign_deadline_todo(event)
    end
  end

  def render_event_owner(event_owner)
    link_to event_owner, "#"
  end

end
