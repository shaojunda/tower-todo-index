class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :team
  belongs_to :user
  has_many :todos, as: :todoable

  after_save :assign_permission_and_generate_event

  def assign_permission_and_generate_event
    ProjectPermission.create([user_id: self.user.id, project_id: self.id, level: "owner"])
    EventService.new(self, self, self.user, ENV["CREATE_PROJECT"], self.team).generate_event
  end

end

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
