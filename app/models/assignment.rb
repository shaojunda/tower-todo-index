class Assignment < ApplicationRecord
end

# == Schema Information
#
# Table name: assignments
#
#  id                 :integer          not null, primary key
#  origin_executor_id :integer
#  new_executor_id    :integer
#  origin_deadline    :datetime
#  new_deadline       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
