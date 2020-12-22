Rails.application.routes.draw do

  get 'favorites/create'
  get 'favorites/destroy'
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
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  get 'books/search', to: "books#search"
  resources :books, only: %i[show] do 
    resources :reviews, except: %i[index]
    collection do
      get "reviews", to: "reviews#index"
    end
  end
end