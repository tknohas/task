class MonthlyRanksController < ApplicationController
  def index
    @user_ranks = Task.group(:executor_id)
                      .where(created_at: Time.current.all_month)
                      .order('COUNT(executor_id) DESC')
                      .count(:executor_id)
                      .map { |executor_id, task_count| [User.find(executor_id), task_count] }
  end
end
