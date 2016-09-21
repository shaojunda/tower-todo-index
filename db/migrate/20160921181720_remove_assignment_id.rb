class RemoveAssignmentId < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :assignment_id
  end
end
