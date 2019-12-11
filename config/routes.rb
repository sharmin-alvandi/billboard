Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/login'
  get 'sessions/welcome'
  get 'users/new'
  get 'users/create'
  get 'billboard/index'
  # get 'billboard/search'
  resources :stores
  resources :collections
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :advertisements do
    collection do
      get :search_store
    end
  end

  resources :users, only: [:new, :create]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'
  # delete '/logout' to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'
  # get 'authorized', to: 'advertisements'
  # get 'store_ads', to: 'advertisements#store_ads'
  root 'billboard#index'
end
