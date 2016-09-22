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
    if @todo.save!
      assignment_params
    else
      render :new
    end
  end

  def show
    @comments = @todo.comments.paginate(page: params[:page], per_page: 10)
  end

  def edit
    render "todos/edit"
  end

  def update
    if @todo.update(todo_params)
      assignment_params
    else
      render :edit
    end
  end

  def destroy
    @todo.delete!
    flash[:alert] = "已删除这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def process_todo
    @todo.process!
    flash[:notice] = "开始处理这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def pause_todo
    @todo.pause!
    flash[:notice] = "暂停处理这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def finish_todo
    @todo.finish!
    flash[:notice] = "已完成这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def reopen_todo
    @todo.reopen!
    flash[:notice] = "已重新打开这个任务"
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

  def assignment_params
    new_params = {}
    assignment = params[:todo][:assignment]
    origin_executor_email = assignment[:origin_executor_email]
    new_executor_email = assignment[:new_executor_email]
    origin_deadline = assignment[:origin_deadline]
    new_deadline = assignment[:new_deadline]
    if origin_executor_email.present?
      @origin_executor = User.find_by_email(origin_executor_email)
      if !@origin_executor.present?
        @assignment = Assignment.new
        flash[:alert] = "无此用户"
        redirect_back(fallback_location: root_path)
        return
      end
      new_params[:origin_executor_id] = @origin_executor.id
    else
      new_params[:origin_executor_id] = nil
    end
    if new_executor_email.present?
      @new_executor = User.find_by_email(new_executor_email)
      if !@new_executor.present?
        @assignment = Assignment.new
        flash[:alert] = "无此用户"
        redirect_back(fallback_location: root_path)
        return
      end
      new_params[:new_executor_id] = @new_executor.id
    else
      new_params[:new_executor_id] = nil
    end

    if origin_deadline.present?
      new_params[:origin_deadline] = origin_deadline
    end

    if new_deadline.present?
      new_params[:new_deadline] = new_deadline
    end
    @assignment = @todo.assignment

    if @assignment.present?
      if @assignment.update(new_params)
        flash[:notice] = "任务更新成功"
        redirect_to team_project_path(@team, @project)
      else
        render :edit
      end
    else
      if @todo.create_assignment!(new_params)
        redirect_to team_project_path(@team, @project)
      else
        flash[:notice] = "出现错误"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description)
  end

end
