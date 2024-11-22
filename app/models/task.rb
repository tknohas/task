class Task < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true

  validates :title, presence: true, length: { maximum: 50 }
  
  scope :incomplete, -> { where(completed_at: nil) }
  scope :complete, -> { where.not(completed_at: nil) }
  scope :assigned_user, -> { where.not(executor: nil) }
end
