Rails.application.routes.draw do
  get 'chat_messages/index'
  devise_for :users
  root to: "home#top"
  resources :diaries do
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
  resources :rooms, only: [:index, :new, :create, :destroy] do
    resources :chat_messages, only: [:index, :create]
  end
end
