class Comment < ApplicationRecord
  belongs_to :todo
  belongs_to :user
  validates :content, presence: true
end

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  todo_id    :integer
#  user_id    :integer
#
