class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :owner_id
      t.integer :creator_id
      t.string :action
      t.integer :eventable_id
      t.string :eventable_type
      t.timestamps
    end
  end
end
