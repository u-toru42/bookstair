# == Route Map
#

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root to: 'books#search'
  root to: 'boards#index'

  get 'search', to: "books#search"

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :books do
    collection { get :search } #このルーティングを追加
  end

  resources :users, only: %i[new create]
end
