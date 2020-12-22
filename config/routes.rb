Rails.application.routes.draw do

  get 'books/search', to: "books#search"
  resources :books, only: %i[show] do 
    resources :reviews, except: %i[index]
    collection do
      get "reviews", to: "reviews#index"
    end
  end

  root to: 'toppages#index'
  resources :users, only: %i[show create edit update]
  get "signup", to: "users#new"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  #ゲストユーザーログイン
  post 'guest_login', to: "guest_sessions#create"
  
end