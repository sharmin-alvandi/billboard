Rails.application.routes.draw do
  
  get 'billboard/index'
  resources :stores
  resources :collections
  resources :advertisements 
  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  root 'billboard#index'
end
