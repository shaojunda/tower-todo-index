class Team < ApplicationRecord
  validates :name, presence: true
  has_many :projects
  has_many :events
  belongs_to :user
end

# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
