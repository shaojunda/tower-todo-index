class RemoveUserIdFromTodo < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :user_id
  end
end
