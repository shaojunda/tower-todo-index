class AddTodoIdToAssignment < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :todo_id, :integer
  end
end
