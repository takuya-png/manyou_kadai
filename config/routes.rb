Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  namespace :admin do
  resources :users
  end
  root 'tasks#index'
  resources :tasks
end