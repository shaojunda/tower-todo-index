module TodosHelper
  def render_todo_description(todo)
    simple_format(todo.description)
  end

  def render_todo_title(team, project, todo)
    link_to todo.title, team_project_todo_path(team, project, todo)
  end

  def render_created_at_for_todo(todo)
    if todo.assignment.present? and todo.assignment.origin_deadline.present?
      todo.assignment.origin_deadline.strftime("%Y年%-m月%d日")
    else
      "没有截止日期"
    end
  end

  def render_todo_executor(todo)
    if todo.assignment.present? and todo.assignment.new_executor.present?
      link_to todo.assignment.new_executor.user_name, "#"
    else
      if todo.assignment.present? and todo.assignment.origin_executor.present?
        link_to todo.assignment.origin_executor.user_name, "#"
      else
        "还没有指定的完成者"
      end
    end
  end

  def get_project_id(todo)
    if todo.todoable.class == Project
      todo.todoable.id
    elsif todo.todoable.class == TodoList
      todo.todoable.project.id
    end
  end

  def render_todo_state(todo)
    if todo.todo_created?
      content_tag(:span, "已创建", class: "label label-default")
    elsif todo.processing?
      content_tag(:span, "正在处理", class: "label label-primary")
    elsif todo.deleted?
      content_tag(:span, "已删除", class: "label label-danger")
    elsif todo.finished?
      content_tag(:span, "已完成", class: "label label-success")
    end
  end


  def render_todo_operate(team, project, todo)
    if todo.todo_created?
      link_to "开始", process_todo_team_project_todo_path(team, project, todo), class: "btn btn-sm btn-success"
    elsif todo.processing?
      link_to "暂停", pause_todo_team_project_todo_path(team, project, todo), class: "btn btn-sm btn-warning"
    elsif todo.finished?
      link_to "重新打开", reopen_todo_team_project_todo_path(team, project, todo), class: "btn btn-sm btn-warning"
    end
  end


end
