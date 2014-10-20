IdleBlog::Application.routes.draw do
  resources :comments, only: [:create, :destroy]
  get 'tags/:tag', to: 'posts#index', as: :tag
  get 'posts/for_moderation', to: 'posts#for_moderation'

  devise_for :users

  resources :posts

  resources :users do
    post :make_admin
    post :make_author
    post :make_reader
    post :make_trusted
  end

  root 'posts#index'
end