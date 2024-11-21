class CompleteTasksController < ApplicationController
  def index
    @completed_tasks = Task.complete.order(completed_at: :desc)
  end
end
