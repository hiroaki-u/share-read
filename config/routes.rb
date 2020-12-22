Rails.application.routes.draw do

  root to: 'toppages#index'
  resources :users, only: %i[show create edit update] do
    member do
      get :followings
      get :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
  get "signup", to: "users#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post 'guest_login', to: "guest_sessions#create"
  

  get 'books/search', to: "books#search"
  resources :books, only: %i[show] do 
    resources :reviews, except: %i[index]
    collection do
      get "reviews", to: "reviews#index"
    end
  end


end