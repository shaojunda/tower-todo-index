class RemoveProjectPermissionFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :project_permission_id
  end
end
