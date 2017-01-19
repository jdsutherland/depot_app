Rails.application.routes.draw do
  resources :orders
  root 'store#index'
  root 'store#index', as: 'store_index'

  resources :carts
  resources :products

  resources :line_items do
    post :decrement, on: :member
  end

  resources :products do
    get :who_bought, on: :member
  end
end
