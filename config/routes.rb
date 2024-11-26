Rails.application.routes.draw do
  root "tasks#index"

  resource :session, only: %i[new destroy]
  resources :tasks, only: %i[index show new create edit update destroy] do
    resource :complete, only: %i[create destroy], module: :tasks
  end
  resources :completed_tasks, only: %i[index]
  resource :webhook, only: :create
  resources :ranks, only: :index
  resources :monthly_ranks, only: :index
  
  get 'line_login_api/callback', to: 'line_login_api#callback'
  get 'line_login_api/login', to: 'line_login_api#login'
end
