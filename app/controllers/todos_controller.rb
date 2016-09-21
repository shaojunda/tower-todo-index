class TodosController < ApplicationController
  before_action :authenticate_user!
  def index
    @todos = Todo.includes([{:assignment => :origin_executor}, :assignment]).all.paginate(page: params[:page], per_page: 50)
  end

  def new
    @todo = Todo.new
    @assignment = Assignment.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    if @todo.save!
      assignment_params
    else
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
    @assignment = @todo.assignment
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
    if @todo.update(todo_params)
      flash[:notice] = "Update Success."
      redirect_to todos_path
    else
      render :edit
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    flash[:alert] = "Todo deleted."
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description)
  end

  def assignment_params
    binding.binding.pry
    new_params = {}
    assignment = params[:todo][:assignment]
    origin_executor_email = assignment[:origin_executor_email]
    new_executor_email = assignment[:new_executor_email]
    origin_deadline = assignment[:origin_deadline]
    new_deadline = assignment[:new_deadline]
    if origin_executor_email.present?
      @origin_executor = User.find_by_email(origin_executor_email)
      if !@origin_executor.present?
        render :new
        flash[:alert] = "无此用户"
        return
      end
      new_params[:origin_executor_id] = @origin_executor.id
    end
    if new_executor_email.present?
      @new_executor = User.find_by_email(new_executor_email)
      if !@new_executor.present?
        render :new
        flash[:alert] = "无此用户"
        return
      end
      new_params[:new_executor_id] = @new_executor.id
    end

    if origin_deadline.present?
      new_params[:origin_deadline] = origin_deadline
    end

    if new_deadline.present?
      new_params[:new_deadline] = new_deadline
    end

    @todo.create_assignment(new_params)
  end

end
