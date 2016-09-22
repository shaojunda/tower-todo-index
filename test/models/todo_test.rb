require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: todos
#
#  id            :integer          not null, primary key
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#  todoable_id   :integer
#  todoable_type :string
#  aasm_state    :string           default("todo_created")
#
# Indexes
#
#  index_todos_on_aasm_state                     (aasm_state)
#  index_todos_on_todoable_id_and_todoable_type  (todoable_id,todoable_type)
#
