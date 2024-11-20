class Tasks::CompletesController < ApplicationController
  def update
    @task = Task.find(params[:task_id])
    @task.update!(completed_at: Time.current)
    redirect_to tasks_path, notice: 'タスクを完了しました'
  end

  def destroy
    @task = Task.find(params[:task_id])
    @task.update!(completed_at: nil)
    redirect_to complete_tasks_index_path, notice: '未完了に戻ししました'
  end
end
