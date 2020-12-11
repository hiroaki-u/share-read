Rails.application.routes.draw do

  get 'guest_sessions/create'
  root to: 'toppages#index'
  resources :users, only: %i[show create edit update]
  get "signup", to: "users#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

end
