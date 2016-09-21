class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :team
  has_many :todos, as: :todoable
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
#
