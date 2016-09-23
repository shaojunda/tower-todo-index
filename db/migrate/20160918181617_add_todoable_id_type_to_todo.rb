class AddTodoableIdTypeToTodo < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :todoable_id, :integer
    add_column :todos, :todoable_type, :string
  end
end
