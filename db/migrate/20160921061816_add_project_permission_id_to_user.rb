class AddProjectPermissionIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :project_permission_id, :integer
  end
end
