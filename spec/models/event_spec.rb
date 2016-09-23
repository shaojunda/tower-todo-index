require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:ownerable) }
  it { is_expected.to belong_to(:creator) }
  it { is_expected.to belong_to(:eventable) }
  it { is_expected.to belong_to(:team) }
end

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
#  team_id        :integer
#
# Indexes
#
#  index_events_on_eventable_id_and_eventable_type  (eventable_id,eventable_type)
#  index_events_on_ownerable_id_and_ownerable_type  (ownerable_id,ownerable_type)
#
