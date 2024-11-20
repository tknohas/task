class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.incomplete.order(created_at: :desc)
  end
  
  def show
  end

  def new
    @task = Current.user.tasks.build
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to edit_task_path(@task), notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
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
    params.expect(task: %i[title executor_id memo completed_at])
  end
  
  def set_task
    @task = Current.user.tasks.find(params[:id])
  end
end
