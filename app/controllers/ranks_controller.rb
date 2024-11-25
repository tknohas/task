class RanksController < ApplicationController
  def index
    @user_ranks = Task.complete
                      .group(:executor_id)
                      .order('COUNT(executor_id) DESC')
                      .count(:executor_id)
                      .reject { |executor_id, _| executor_id.nil? }
                      .map { |executor_id, task_count| [User.find(executor_id), task_count] }
  end
end
