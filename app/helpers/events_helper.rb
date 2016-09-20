module EventsHelper

  EVENT_ACTION = { create_team: "创建了团队", create_project: "创建了项目", create_todo: "创建了任务", create_todo_with_executor: "", assign_executor_todo: "", finish_todo: "完成了任务", assign_deadline_todo: "", reopen_todo: "重新打开了任务", start_process_todo: "开始处理这条任务", pause_process_todo: "暂停处理这条任务", delete_todo: "删除了任务", recover_todo: "恢复了任务", cancel_todo: "", reply_todo: "回复了任务" }

  def render_created_at(create_at)
    create_at.strftime("%Y-%m-%d %H:%M")
  end

  def render_event_content(event)
    if event.eventable.class == Todo
      event.eventable.title
    elsif event.eventable.class == Team
      event.eventable.name
    elsif event.eventable.class == Project
      event.eventable.name
    elsif event.eventable.class == Comment
      event.eventable.todo.todoable.name
    end
  end

  def render_head_pic
    rand_num = rand(4) + 1
    image_tag("user#{rand_num}.png", size:"50x50")
  end

  def create_todo_with_executor(event)
    render partial: "events/event_content", locals: {action: "为 #{event.eventable.assignment.origin_executor.user_name} 创建了任务", event_content: render_event_content(event) }
  end

  def assign_executor_todo(event)
    if event.eventable.assignment.new_executor.present?
      render partial: "events/event_content", locals: {action: "把 #{event.eventable.assignment.origin_executor.user_name} 的任务指派给 #{event.eventable.assignment.new_executor.user_name}", event_content: render_event_content(event) }
    else
      render partial: "events/event_content", locals: {action: "给 #{event.eventable.assignment.origin_executor.user_nam} 指派了任务", event_content: render_event_content(event) }
    end
  end

  def assign_deadline_todo(event)
    origin_deadline = format_date_for_deadline(event.eventable.assignment.origin_deadline)
    if event.eventable.assignment.new_deadline.present?
      new_deadline = format_date_for_deadline(event.eventable.assignment.new_deadline)

      render partial: "events/event_content", locals: {action: "将任务完成时间从 #{origin_deadline} 修改为 #{new_deadline}", event_content: render_event_content(event) }
    else
      render partial: "events/event_content", locals: {action: "将任务完成时间从 没有截止日 修改为 #{origin_deadline}", event_content: render_event_content(event) }
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

  def cancel_todo(event)
    render partial: "events/event_content", locals: {action: "取消了 #{event.eventable.assignment.origin_executor.user_name} 的任务", event_content: render_event_content(event) }
  end

  def reply_todo(event)
    render partial: "events/event_content_with_comment", locals: {action: EVENT_ACTION.fetch(:reply_todo), event_content: render_event_content_for_comment(event), event_comment: render_comment(event)}
  end

  def render_event_action(event)
    event_action = ""
    case event.action
    when "create_team"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:create_team), event_content: render_event_content(event) }
    when "create_project"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:create_project), event_content: render_event_content(event) }
    when "create_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:create_todo), event_content: render_event_content(event) }
    when "create_todo_with_executor"
      create_todo_with_executor(event)
    when "assign_executor_todo"
      assign_executor_todo(event)
    when "finish_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:finish_todo), event_content: render_event_content(event) }
    when "assign_deadline_todo"
      assign_deadline_todo(event)
    when "reopen_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:reopen_todo), event_content: render_event_content(event) }
    when "start_process_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:start_process_todo), event_content: render_event_content(event) }
    when "pause_process_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:pause_process_todo), event_content: render_event_content(event) }
    when "delete_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:delete_todo), event_content: render_event_content(event) }
    when "recover_todo"
      render partial: "events/event_content", locals: {action: EVENT_ACTION.fetch(:recover_todo), event_content: render_event_content(event) }
    when "cancel_todo"
      cancel_todo(event)
    when "reply_todo"
      reply_todo(event)
    end
  end

  def render_creator_name(event)
    link_to event.creator.user_name, "#"
  end

  def render_comment(event)
    truncate(sanitize(event.eventable.content), length: 157)
  end

  def render_event_content_for_comment(event)
    truncate(event.eventable.todo.title, length: 77)
  end

  def render_event_owner(event_owner, event)
    link_to render_event_content(event), "#"
  end

end
