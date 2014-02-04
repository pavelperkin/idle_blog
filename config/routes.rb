IdleBlog::Application.routes.draw do
  resources :comments, only: [:create, :destroy]

  devise_for :users
  resources :posts
  root 'posts#index'
end