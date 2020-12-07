Rails.application.routes.draw do
  get 'users/show'
  get 'users/create'
  get 'users/edit'
  get 'users/update'
  get 'users/new'
  root to: 'toppages#index'
  get "signup", to: "users#new"
  resources :users, only: %i[show, create, edit, update]
end
