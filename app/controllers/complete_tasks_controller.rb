class CompleteTasksController < ApplicationController
  def index
    @completed_tasks = Task.complete.order(created_at: :desc)
  end
end
