Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  resources :diaries do
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
end
