IdleBlog::Application.routes.draw do
  resources :comments, only: [:create, :destroy]
  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'users/make_admin', to: 'users#make_admin'
  get 'users/make_author', to: 'users#make_author'
  get 'users/make_reader', to: 'users#make_reader'
  get 'users/make_trusted', to: 'users#make_trusted'
  get 'posts/for_moderation', to: 'posts#for_moderation'
  devise_for :users
  resources :posts
  resources :users
  root 'posts#index'
end