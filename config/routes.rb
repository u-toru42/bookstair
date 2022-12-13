Rails.application.routes.draw do
  get 'authors/index'
  get 'tags/index'
  get 'books/index'
  get 'bookmarks/index'
  get 'comments/index'
  get 'reviews/index'
  get 'checks/index'
  get 'lines/index'
  get 'bookshelf_line/index'
  get 'bookshelf/index'
  get 'bookshelf_follow/index'
  root to: 'boards#index'
  resources :boards
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
