module TodosHelper
  def render_todo_description(todo)
    simple_format(todo.description)
  end

  def render_title(todo)
    link_to todo.title, todo_path(todo)
  end

  def render_created_at(todo)
    if todo.assignment
      todo.assignment.origin_deadline.strftime("%Y年%-m月%d日")
    else
      "没有截止日期"
    end
  end

  def render_executor(todo)
    if todo.assignment
      link_to todo.assignment.origin_executor.user_name, "#"
    else
      "还没有指定的完成者"
    end
  end

  def get_project_id(todo)
    if todo.todoable.class == Project
      todo.todoable.id
    elsif todo.todoable.class == TodoList
      todo.todoable.project.id
    end
  end
end
