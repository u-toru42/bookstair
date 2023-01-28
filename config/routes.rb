Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'bookshelves#index'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :books do
    collection { get :search } #このルーティングを追加
  end

  resources :bookshelves, only: %i[index new create show edit update destroy]

  resources :users, only: %i[new create]
end
