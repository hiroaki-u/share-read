Rails.application.routes.draw do

  root to: 'toppages#index'
  resources :users, only: %i[show create edit update]
  get "signup", to: "users#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy"

end
