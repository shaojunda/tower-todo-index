# == Schema Information
#
# Table name: events
#
#  id             :integer          not null, primary key
#  creator_id     :integer
#  action         :string
#  eventable_id   :integer
#  eventable_type :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ownerable_id   :integer
#  ownerable_type :string
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_ownerable_id_and_ownerable_type  (ownerable_id,ownerable_type)
#

require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
