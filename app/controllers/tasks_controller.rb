class TasksController < ApplicationController
  def new
    @task = Current.user.tasks.build
  end

  def create
    @task = Current.user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: '登録しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.expect(task: %i[title executor_id memo completed_at])
  end
end
