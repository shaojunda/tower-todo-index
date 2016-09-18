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
#  assignment_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#  todoable_id   :integer
#  todoable_type :string
#
