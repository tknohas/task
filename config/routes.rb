Rails.application.routes.draw do
  root "home#index"

  resource :session
  resources :passwords, param: :token
  resources :tasks, only: %i[new create edit update]
end
