class ProjectPermission < ApplicationRecord
end

# == Schema Information
#
# Table name: project_permissions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  project_id :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
