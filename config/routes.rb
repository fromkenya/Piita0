Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

