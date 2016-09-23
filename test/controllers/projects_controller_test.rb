# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  project_type :integer          default(1)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  team_id      :integer
#  user_id      :integer
#

require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
