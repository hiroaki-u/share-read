Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'toppages#index'
  get "signup", to: "users#new"
  resources :users, only: %i[show create edit update]
end
