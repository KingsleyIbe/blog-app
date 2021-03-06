Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create]
  end
  root 'users#index'
end
