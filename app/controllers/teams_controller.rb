class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_team_permission, :except => [:index, :new, :create]

  def index
    team_permissions = current_user.team_permissions.select("team_id")
    @teams = Team.includes(:user).where( id: team_permissions ).paginate(page: params[:page], per_page: 50)
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


  protected

  def check_team_permission
    unless current_user.has_permission_to_access_to_team?(params[:id])
      flash[:alert] = "等等，你好像不是我们机组的"
      redirect_to "/"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

end
