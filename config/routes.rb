Rails.application.routes.draw do
  root 'store#index'
  root 'store#index', as: 'store_index'

  resources :line_items
  resources :carts
  resources :products
end
