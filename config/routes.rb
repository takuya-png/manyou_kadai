Rails.application.routes.draw do
  namespace :admin do
    resources :users
  end
  resources :users, only: [:index, :new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  root 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
end