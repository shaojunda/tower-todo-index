class TodoStatesController < ApplicationController

  before_action :find_team_and_project_and_todo

  def new
    @todo.process!
    flash[:notice] = "开始处理这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def edit
    @todo.pause!
    flash[:notice] = "暂停处理这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def update
    @todo.reopen!
    flash[:notice] = "已重新打开这个任务"
    redirect_to team_project_path(@team, @project)
  end

  def destroy
    @todo.finish!
    flash[:notice] = "已完成这个任务"
    redirect_to team_project_path(@team, @project)
  end

  protected

  def find_team_and_project_and_todo
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
    @todo = @project.todos.find(params[:todo_id])
  end

end
