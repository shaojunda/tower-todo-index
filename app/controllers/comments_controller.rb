class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_team_and_project_and_todo
  before_action :find_comment, :only => [:edit, :update, :destroy]
  before_action do
    check_permission(params[:project_id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @todo.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = "评论发布成功"
      redirect_to team_project_todo_path(@team, @project, @todo)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "评论修改成功"
      redirect_to team_project_todo_path(@team, @project, @todo)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:alert] = "成功删除这条评论"
    redirect_to team_project_todo_path(@team, @project, @todo)
  end

  protected

  def find_comment
    @comment = @todo.comments.find(params[:id])
  end

  def find_team_and_project_and_todo
    @team = Team.find(params[:team_id])
    @project = @team.projects.find(params[:project_id])
    @todo = @project.todos.find(params[:todo_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
