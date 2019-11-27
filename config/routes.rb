Rails.application.routes.draw do
  get 'billboard/index'
  resources :stores
  resources :collections
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :advertisements
  root 'billboard#index'
end
