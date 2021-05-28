Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :edit, :update, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users
  end
  root 'tasks#index'
  resources :tasks do
    collection do
      post :confirm
    end
  end
end