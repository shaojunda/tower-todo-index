class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project, :except => [:index]
  before_action :find_todo, :except => [:index, :new, :create]
  before_action :find_assignment, :only => [:show, :edit]
  before_action do
    check_permission(params[:project_id])
  end

  def index
    @todos = Todo.includes([{:assignment => :origin_executor}, :assignment]).all.paginate(page: params[:page], per_page: 50)
  end

  def new
    @todo = Todo.new
    @assignment = Assignment.new
  end

  def create
    @todo = @project.todos.build(todo_params)
    @todo.user = current_user
    if @todo.save!
      # assignment_params
      new_assignment_params(0)
    else
      render :new
    end
  end

  def show
    @comments = @todo.comments.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def edit
    render "todos/edit"
  end

  def update
    if @todo.update!(todo_params)
      # assignment_params
      new_assignment_params(1)
    else
      render :edit
    end
  end

  def destroy
    @todo.delete!
    EventService.new(@project, @todo, @todo.user, ENV["DELETE_TODO"], @team).generate_event
    flash[:alert] = "已删除这个任务"
    redirect_to team_project_path(@team, @project)
  end


  protected

  def find_assignment
    @assignment = @todo.assignment
    if @assignment.blank?
      @assignment = Assignment.new
    else
      if @assignment.origin_executor.present?
        @assignment.origin_executor_email = @assignment.origin_executor.email
      end
      if @assignment.new_executor.present?
        @assignment.new_executor_email = @assignment.new_executor.email
      end
    end
  end

  def find_todo
    @todo = @project.todos.find(params[:id])
  end

  def find_team_and_project
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
  end

  def create_assignment(assignment)
    new_params = {}
    if assignment[:origin_executor_email].present?
      origin_executor = User.find_by_email(assignment[:origin_executor_email])
      if !origin_executor.present?
        assignment = Assignment.new
        flash[:alert] = "无此用户"
        redirect_back(fallback_location: root_path)
        return
      end
      new_params[:origin_executor] = origin_executor
    end
    if assignment[:origin_deadline].present?
      new_params[:origin_deadline] = assignment[:origin_deadline]
    end
    if new_params.size > 0
      if @todo.create_assignment(new_params)
        if new_params[:origin_executor].present?
          EventService.new(@todo.todoable, @todo, current_user, ENV["CREATE_TODO_WITH_EXECUTOR"], @todo.todoable.team).generate_event
        end
      else
        flash[:notice] = "出现错误"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update_assignment(old_assignment, new_assignment)
    new_params = {}
  # TODO: 当存在旧的 new_assignment 时，当去掉 new_executor 时 要执行取消操作。当去掉 origin_executor 时不进行任何操作
    if old_assignment.origin_executor.present?
      new_params[:origin_executor] = old_assignment.origin_executor
      if new_assignment[:new_executor_email].present?
        new_executor = User.find_by_email(new_assignment[:new_executor_email])
        if !new_executor.present?
          assignment = Assignment.new
          flash[:alert] = "无此用户"
          redirect_back(fallback_location: root_path)
          return
        end
        new_params[:new_executor] = new_executor
      end
      if new_assignment[:origin_deadline].present?
        new_params[:origin_deadline] = new_assignment[:origin_deadline]
      end
      if new_assignment[:new_deadline].present?
        new_params[:new_deadline] = new_assignment[:new_deadline]
      end
      binding.pry
      old_new_executor = old_assignment.new_executor
      if old_assignment.update(new_params)
        if new_assignment[:origin_executor_email].blank? && new_params[:new_executor].blank?
          EventService.new(@todo.todoable, @todo, current_user, ENV["CANCEL_TODO"], @todo.todoable.team).generate_event
        else
          if new_executor.present? && new_executor != old_new_executor
            EventService.new(@todo.todoable, @todo, current_user, ENV["ASSIGN_NEW_EXECUTOR_TODO"], @todo.todoable.team).generate_event
          end
        end
        flash[:notice] = "任务更新成功"
        redirect_to team_project_path(@team, @project)
      else
        render :edit
      end
    else
      if new_assignment[:origin_executor_email].present?
        origin_executor = User.find_by_email(new_assignment[:origin_executor_email])
        if !origin_executor.present?
          assignment = Assignment.new
          flash[:alert] = "无此用户"
          redirect_back(fallback_location: root_path)
          return
        end
        new_params[:origin_executor] = origin_executor
      end

      if new_assignment[:origin_deadline].present?
        new_params[:origin_deadline] = new_assignment[:origin_deadline]
      end
      if new_assignment[:new_deadline].present?
        new_params[:new_deadline] = new_assignment[:new_deadline]
      end
      if old_assignment.update(new_params)
        if origin_executor.present?
          EventService.new(@todo.todoable, @todo, current_user, ENV["ASSIGN_EXECUTOR_TODO"], @todo.todoable.team).generate_event
        end
        flash[:notice] = "任务更新成功"
        redirect_to team_project_path(@team, @project)
      else
        render :edit
      end
    end

  end

  def new_assignment_params(type)
    # 获得 assignment_params
    assignment = params[:todo][:assignment]

    # create
    if type == 0
      create_assignment(assignment)

    # update
    elsif type == 1
      old_assignment = @todo.assignment
      update_assignment(old_assignment, assignment)
    end
  end


  private

  def todo_params
    params.require(:todo).permit(:title, :description)
  end

end
