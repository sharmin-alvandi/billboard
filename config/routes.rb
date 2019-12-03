Rails.application.routes.draw do
  get 'billboard/index'
  get 'billboard/search'
  resources :stores
  resources :collections
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :advertisements do
    collection do
      get :search_store 
    end
  end
  # get 'store_ads', to: 'advertisements#store_ads'
  root 'billboard#index'
end
