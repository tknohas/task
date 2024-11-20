class CompleteTasksController < ApplicationController
  def index
    @completed_tasks = Task.complete.order(created_at: :desc)
  end

  def show
    @completed_task = Task.complete.find(params[:id])
  end
end
