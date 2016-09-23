class AddOwnerableToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :ownerable_id, :integer
    add_column :events, :ownerable_type, :string
    add_index :events, [:ownerable_id, :ownerable_type]
    add_index :events, [:eventable_id, :eventable_type]
    add_index :todos, [:todoable_id, :todoable_type]
  end
end
