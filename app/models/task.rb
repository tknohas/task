class Task < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true

  validates :title, presence: true, length: { maximum: 50 }
end
