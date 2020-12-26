Rails.application.routes.draw do

  root to: 'toppages#index'

  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post 'guest_login', to: "guest_sessions#create"

  resources :users, only: %i[show create edit update] do
    member do
      get :followings
      get :followers
      get :favorites
      get :bookcases
      get :draft
    end
  end
  resources :favorites, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
  resources :bookcases, only: %i[create destroy]

  get 'books/search', to: "books#search"
  resources :books, only: %i[show] do 
    resources :reviews, except: %i[index] do 
      resources :comments, only: %i[create update edit destroy]
    end
    collection do
      get "reviews", to: "reviews#index"
    end
  end
  
  resources :notifications, only: %i[index]

end