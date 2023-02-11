# == Route Map
#

Rails.application.routes.draw do
  # devise_for :users
  # get 'books/search'
  get 'comments/create'
  get 'comments/destroy'

  # Defines the root path route ("/")
  # root "articles#index"
<<<<<<< Updated upstream
  root to: 'bookshelves#index'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  
  resources :books do
    collection { get :search } #このルーティングを追加
=======
  # get 'mypage', to: 'users#me' 
  root to: 'books#index'
  # root "home#top"
  # devise_for :users, controllers: {
  #   # ↓ローカルに追加されたコントローラーを参照する(コントローラー名: "コントローラーの参照先")
  #   registrations: "users/registrations",
  #   sessions: "users/sessions",
  #   passwords: "users/passwords",
  #   confirmations: "users/confirmations"
  # }
  devise_for :users, controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
>>>>>>> Stashed changes
  end
  
  resources :books, param: :isbn, constraints: { code: /\d+/ } do
    collection { get :search }
    resources :comments, only: %i[create destroy]
  end
  # resources :books, only: %i[search show], param: :isbn, constraints: { code: /\d+/ } do
  # resources :books, only: %i[search show], param: :isbn do
  #   resources :comments, only: %i[create destroy]
  # end

  resources :bookshelves, only: %i[index new create show edit update destroy]

  # resources :users, only: %i[new create]

<<<<<<< Updated upstream
  resources :bookshelves, only: %i[index new create show edit update destroy]

  resources :users, only: %i[new create]
=======
>>>>>>> Stashed changes
end
