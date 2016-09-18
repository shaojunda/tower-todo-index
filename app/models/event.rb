class Event < ApplicationRecord
end

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
