Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] do
    resources :likes, only: [:index]
  end
  resources :stocks, only: [:index]
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :stocks, only: [:create, :destroy]
  end

  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

