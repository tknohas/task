class Tasks::CompletesController < ApplicationController
  before_action :set_task, only: %i[create destroy]
  
  def create
    @task.update!(completed_at: Time.current)
    redirect_to tasks_path, notice: 'タスクを完了しました'
  end

  def destroy
    @task.update!(completed_at: nil)
    redirect_to completed_tasks_path, notice: '未完了に戻ししました'
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
