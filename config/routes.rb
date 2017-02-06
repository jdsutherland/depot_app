Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    get    'login'  => :new
    post   'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :products

  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :line_items do
      post :decrement, on: :member
    end
    resources :orders
    resources :carts
    root 'store#index'
    root 'store#index', as: 'store_index'
  end
end
