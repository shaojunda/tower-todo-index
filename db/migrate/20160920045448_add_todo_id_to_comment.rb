class AddTodoIdToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :todo_id, :integer
  end
end
