class DelOwnerIdFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :owner_id
  end
end
