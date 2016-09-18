# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  owner_id       :integer
#  creator_id     :integer
#  action         :string
#  eventable_id   :integer
#  eventable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
