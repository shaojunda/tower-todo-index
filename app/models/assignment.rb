class Assignment < ApplicationRecord
  belongs_to :origin_executor, class_name: "User", optional: true
  belongs_to :new_executor, class_name: "User", optional: true
  attr_accessor :origin_executor_email, :new_executor_email
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
#  todo_id            :integer
#
