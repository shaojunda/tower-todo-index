class Todo < ApplicationRecord
  validates :title, presence: true
  validates :title, length: { maximum: 1000 }
  has_one :assignment, :dependent => :destroy
  belongs_to :todoable, polymorphic: true
  has_many :comments

  include AASM

  aasm do
    state :todo_created, initial: true
    state :processing
    state :deleted
    state :finished

    event :process do
      transitions from: :todo_created, to: :processing
    end

    event :pause do
      transitions from: :processing, to: :todo_created
    end

    event :delete do
      transitions from: %i(todo_created processing paused), to: :deleted
    end

    event :finish do
      transitions from: %i(todo_created processing paused), to: :finished
    end

    event :reopen do
      transitions from: :finished, to: :todo_created
    end



  end

end

# == Schema Information
#
# Table name: todos
#
#  id            :integer          not null, primary key
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#  todoable_id   :integer
#  todoable_type :string
#  aasm_state    :string           default("todo_created")
#  user_id       :integer
#
# Indexes
#
#  index_todos_on_aasm_state                     (aasm_state)
#  index_todos_on_todoable_id_and_todoable_type  (todoable_id,todoable_type)
#
