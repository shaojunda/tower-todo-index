class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save

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

end
