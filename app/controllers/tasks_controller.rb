class TasksController < ApplicationController
  before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = Task.incomplete.order(created_at: :desc)
  end
  
  def show
    @task = Task.incomplete.find(params[:id])
  end

  def new
    @task = Current.user.tasks.build
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      if @task.executor_id.present? && @task.executor_id != @task.user_id
        NotifyAssignedJob.perform_later(@task, task_url(@task))
      end
      redirect_to edit_task_path(@task), notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      if @task.executor_id.present? && @task.executor_id != @task.user_id
        NotifyAssignedJob.perform_later(@task, task_url(@task))
      end
      redirect_to edit_task_path(@task), notice: '変更しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: '削除しました'
  end

  private

  def task_params
    params.expect(task: %i[title executor_id description completed_at])
  end
  
  def set_task
    @task = Current.user.tasks.find(params[:id])
  end
end
