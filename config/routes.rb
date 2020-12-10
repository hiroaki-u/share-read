Rails.application.routes.draw do

  root to: 'toppages#index'
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#new"
  get "logout", to: "sessions#destroy"
  resources :users, only: %i[show create edit update]
end
