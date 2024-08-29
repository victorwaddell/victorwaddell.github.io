Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # Only need two routes for the API
      get 'orders', to: 'orders#index'
      get 'customers/:id', to: 'customers#show'
    end
  end

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
 
  root 'home#index'

  # Authentication routes
  get 'login', to: 'sessions#new', as: :login
  post 'sessions', to: 'sessions#create', as: :sessions
  get 'logout', to: 'sessions#destroy', as: :logout

  # Resource Routes (maps HTTP verbs to controller actions automatically):
  resources :users, except: [:show, :destroy]
  resources :customers
  resources :categories, except: [:show, :destroy]
  resources :addresses 
  resources :item_prices, except: [:index, :show, :edit, :update, :destroy]
  resources :orders
  get 'search', to: 'search#search', as: :search

  resources :items
  patch 'items/:id/active', to: 'items#toggle_active', as: :toggle_active
  patch 'items/:id/feature', to: 'items#toggle_feature', as: :toggle_feature

  get 'cart/view', to: 'cart#show', as: :view_cart
  get 'cart/:id/add_item', to: 'cart#add_item', as: :add_item
  get 'cart/:id/remove_item', to: 'cart#remove_item', as: :remove_item
  get 'cart/empty_cart', to: 'cart#empty_cart', as: :empty_cart
  get 'cart/checkout', to: 'cart#checkout', as: :checkout

  
end
