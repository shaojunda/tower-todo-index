require 'test_helper'

class TeamPermissionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: team_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  team_id    :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
