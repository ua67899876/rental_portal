class Appointment < ApplicationRecord
  belongs_to :requester, class_name: :User, foreign_key: :requester_id
  belongs_to :moderator, class_name: :User, foreign_key: :moderator_id
  
  belongs_to :apartment

  enum status: {
    waiting: 0,
    pending: 1,
    visited: 2
  }

  scope :not_visited, -> { where.not(status: :visited) }
end
