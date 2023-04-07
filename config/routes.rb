# == Route Map
#

Rails.application.routes.draw do
  # devise_for :users
  # get 'books/search'
  # get 'bookmarks/create'
  # get 'bookmarks/destroy'

  # Defines the root path route ("/")
  # root "articles#index"
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
  devise_for :users
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  resources :books, param: :isbn, constraints: { code: /\d+/ } do
    collection do 
      get :search
      get :autocomplete
    end
    resources :bookmarks, only: %i[create destroy edit update], shallow: true
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end
