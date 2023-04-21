# == Route Map
#

Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  
  get 'likes/create'
  get 'likes/destroy'
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
  
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == ['admin', Rails.application.credentials.basic[:user_password].to_s]
  end

  authenticate :user do #authenticate
    mount Sidekiq::Web => '/sidekiq'
  end
  
  resources :books, param: :isbn, constraints: { code: /\d+/ } do
    collection do 
      get :search
      get :autocomplete
    end
    resources :bookmarks, only: %i[create destroy], shallow: true
  end
  resources :bookmarks, only: %i[index edit update] 

  Sidekiq::Web.use(Rack::Auth::Basic) do |user_id, password|
    [user_id, password] == [ENV['USER_ID'], ENV['USER_PASSWORD']]
  end
  mount Sidekiq::Web, at: '/sidekiq'

end
