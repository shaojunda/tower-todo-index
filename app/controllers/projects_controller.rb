class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def show
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:id])
    @todos = @project.todos.includes([{:assignment => :origin_executor},{:assignment => :new_executor} , :assignment, :todoable]).paginate(page: params[:page], per_page: 50)
  end

  def new
    @project = Project.new
  end

  def create
    @team = Team.find(params[:team_id])
    @project = @team.projects.build(project_params)
    if @project.save
      flash[:notice] = "成功创建项目"
      redirect_to team_project_index_path(@team)
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end


end
