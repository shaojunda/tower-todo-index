class AddDefaultType < ActiveRecord::Migration[5.0]
  def change
    change_column_default :projects, :project_type, 1
  end
end
