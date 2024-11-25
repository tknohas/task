class RanksController < ApplicationController
  def index
    @user_ranks = User.find(Task.group(:executor_id).order('count(executor_id) desc').pluck(:executor_id))
  end
end
