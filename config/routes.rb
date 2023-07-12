# == Route Map
#

Rails.application.routes.draw do
  # require 'sidekiq/web'
  # require 'sidekiq-scheduler/web'
  
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
    # registrations: "users/registrations",
  #   sessions: "users/sessions",
    # passwords: "users/passwords",
  #   confirmations: "users/confirmations"
  # }
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  # Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  #   [user, password] == ['admin', Rails.application.credentials.basic[:user_password].to_s]
  # end

  # authenticate :user do #authenticate
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # resources :users, only: %i[show edit update]
  
  resources :books, param: :isbn do
    collection do 
      get :search
      get :autocomplete
    end
    resources :bookmarks, only: %i[create destroy], shallow: true
    resources :favorites, only: %i[create destroy]
  end
  resources :bookmarks, only: %i[index edit update]
  get 'bookmarks/my_bookmarks', to: 'bookmarks#my_bookmarks'
  resources :favorites, only: %i[index destroy]

  # resources :feeds, only: %i[index]

end
