class Project < ApplicationRecord
end

# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  name         :string
#  description  :text
#  project_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
