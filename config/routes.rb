Rails.application.routes.draw do
  root "tasks#index"

  resource :session
  resources :passwords, param: :token
  resources :tasks, only: %i[index show new create edit update destroy]
end
