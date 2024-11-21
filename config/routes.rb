Rails.application.routes.draw do
  root "tasks#index"

  resources :users, only: :index do
    resource :sign_in, only: :create, module: :users
  end
  resource :session, only: :destroy
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy] do
    resource :complete, only: %i[create destroy], module: :tasks
  end
  resources :completed_tasks, only: %i[index]
  resource :webhook, only: :create
end
