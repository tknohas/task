Rails.application.routes.draw do
  get "complete_tasks/index"
  get "complete_tasks/show"
  root "tasks#index"

  resource :session
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy] do
    resource :complete, only: %i[update destroy], module: :tasks
  end
  resources :completed_tasks, only: %i[index]
end
