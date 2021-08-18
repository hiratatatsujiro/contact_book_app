Rails.application.routes.draw do
  devise_for :users, controllers: {   registrations: 'users/registrations',
                                      sessions: 'users/sessions' }
  root to: "home#top"
  resources :diaries do
    collection do
      get 'search'
    end
    resources :comments, only: :create
  end
  resources :users, only: [:show, :edit, :update]
  resources :rooms, only: [:index, :new, :create, :destroy] do
    resources :chat_messages, only: [:index, :create]
  end
  resources :items do
    collection do
      get 'search'
    end
    resources :item_comments, only: :create
    resources :orders, only: [:index, :create]
  end
  resources :class_communications do
    collection do
      get 'search'
    end
  end
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :timetables
  resources :contacts
end
