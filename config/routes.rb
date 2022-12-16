Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'books#search'
  get 'books/search', to: "books#search"
  # get '/search', to: 'books#search'
  
  resources :books do
    collection { get :search }#このルーティングを追加
  end
end
