Rails.application.routes.draw do
  resources :orders
  root 'store#index'
  root 'store#index', as: 'store_index'

  resources :carts
  resources :products

  resources :line_items do
    member do
      post 'decrement'
    end
  end
end
