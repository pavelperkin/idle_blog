IdleBlog::Application.routes.draw do
  resources :comments, only: [:create, :destroy]
  get 'tags/:tag', to: 'posts#index', as: :tag
  devise_for :users
  resources :posts
  root 'posts#index'
end