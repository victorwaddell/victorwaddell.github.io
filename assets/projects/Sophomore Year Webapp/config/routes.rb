Rails.application.routes.draw do
  # Only need two routes for the API
  # do NOT use the resources() method for route generation
  get 'orders', to: 'orders#index', as: :orders # index action
  get 'customers/:id', to: 'customers#show', as: :customer  #show action
  

end
