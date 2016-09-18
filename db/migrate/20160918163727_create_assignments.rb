class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer :origin_executor_id
      t.integer :new_executor_id
      t.datetime :origin_deadline
      t.datetime :new_deadline

      t.timestamps
    end
  end
end
