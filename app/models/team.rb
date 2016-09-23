class Team < ApplicationRecord
  validates :name, presence: true
  has_many :projects
  has_many :events
  belongs_to :user

  after_save :assion_team_permission

  def assion_team_permission
    TeamPermission.create([user_id: current_user.id, team_id: self.id, level: "owner"])
  end
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
