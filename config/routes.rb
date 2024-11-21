Rails.application.routes.draw do
  root "tasks#index"

  resources :users, only: :index do
    resource :sign_in, only: :create, module: :users
  end
  resource :session, only: :destroy
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy] do
    resource :complete, only: %i[update destroy], module: :tasks # TODO: updateではなくcreateで実装
  end
  resources :complete_tasks, only: %i[index] #TODO: completed_tasksに変更
  resource :webhook, only: :create
end
