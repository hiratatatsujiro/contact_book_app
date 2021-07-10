Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  resources :diaries, only: [:index, :new, :create]
  resources :users, only: [:show, :edit, :update]
end
