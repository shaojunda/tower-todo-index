class TeamsController < ApplicationController
  before_action :authenticate_user!

  def index
    @teams = Team.includes(:user).all.paginate(page: params[:page], per_page: 50)
  end

  def show
    @team = Team.find(params[:id])
    @projects = @team.projects.paginate(page: params[:page], per_page: 10)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      flash[:notice] = "成功创建了团队"
      redirect_to teams_path
    else
      render :new
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end
