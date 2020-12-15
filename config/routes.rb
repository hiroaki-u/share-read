Rails.application.routes.draw do

  get 'books/search', to: "books#search"
  resources :books, only: %i[show]

  root to: 'toppages#index'
  resources :users, only: %i[show create edit update]
  get "signup", to: "users#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  #ゲストユーザーログイン
  post 'guest_login', to: "guest_sessions#create"
  resources :reviews
end
