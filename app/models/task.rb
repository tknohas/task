class Task < ApplicationRecord
  before_create :assign_executor

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :executor, class_name: 'User', foreign_key: 'executor_id', optional: true

  validates :title, presence: true, length: { maximum: 50 }
  
  scope :incomplete, -> { where(completed_at: nil) }
  scope :complete, -> { where.not(completed_at: nil) }
  scope :assigned_user, -> { where.not(executor: nil) }

  private

  def assign_executor
    task_counts = Task.complete.group(:executor_id).count
    all_user_ids = User.pluck(:id)

    all_user_ids.each do |user_id|
      task_counts[user_id] ||= 0
    end

    least_assinged_user_id = task_counts.min_by { |_user_id, count| count }[0]
    self.executor_id = least_assinged_user_id
  end
end
