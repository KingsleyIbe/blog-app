# Rails.application.routes.draw do
#   devise_for :users

#   root to: "users#index"
#   resources :users, only: [:index, :show] do
#     resources :posts, only: [:index, :show, :new, :create, :destroy] do
#       post "new_comment", to: "comments#create", on: :member
#       post "like_post", to: "likes#create", on: :member
#       post "like_post", to: "likes#create", on: :member
#     end
#   end

#   resources :comments, only: [:destroy]
# end

Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      post "new_comment", to: "comments#create", on: :member
      post "like_post", to: "likes#create", on: :member
      post "like_post", to: "likes#create", on: :member
    end
  end

  resources :comments, only: [:destroy]
end
