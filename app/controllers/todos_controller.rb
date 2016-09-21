class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project, :except => [:index]
  before_action :find_todo, :except => [:index, :new, :create]
  before_action :find_assignment, :only => [:show, :edit]

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
      assignment_params
    else
      render :new
    end
  end

  def show
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
    @todo.destroy
    flash[:alert] = "任务已删除"
    redirect_to team_project_path(@team, @project)
  end

  protected

  def find_assignment
    @assignment = @todo.assignment
    if @assignment.blank?
      @assignment = Assignment.new
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
