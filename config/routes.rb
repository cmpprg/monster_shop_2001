Rails.application.routes.draw do
  #welcome
  # root 'welcome#index'

  get '/', to: 'welcome#index'

  # resources :merchants do
  #   resources :items, only: [:index, :new, :create], controller: :merchant_items
  # end

  # merchant
  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  # merchant_items
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  post '/merchants/:merchant_id/items', to:'merchant_items#create'

  # resources :items, except: [:new, :create] do
  #     resources :reviews, only: [:new, :create]
  # end

  # items
  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  # reviews
  get 'items/:item_id/reviews/new', to: 'reviews#new'
  post 'items/:item_id/reviews', to: 'reviews#create'

  # resources :reviews, only: [:edit, :update, :destroy]

  get 'reviews/:id/edit', to: 'reviews#edit'
  patch 'reviews/:id', to: 'reviews#update'
  delete 'reviews/:id', to: 'reviews#destroy'



  #cart
  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
  patch '/cart/:item_id', to: 'cart#add_or_sub'

  #orders
  # resources :orders, only: [:new, :create, :show, :update]

  post '/orders', to: 'orders#create'
  get '/orders/new', to: 'orders#new'
  get '/orders/:id', to: 'orders#show'
  patch '/orders/:id', to: 'orders#update'

  #register
  get '/register', to: 'register#new'
  post '/register', to: 'register#create'

  #login
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'

  #logout
  delete '/logout', to: 'session#destroy'

  #password_reset
  # resource :password, only: [:edit, :update]
  get '/password/edit', to: 'passwords#edit'
  patch '/password', to: 'passwords#update'

  # namespace :profile do
    # resources :orders, only: [:index, :show, :update]
    get 'profile/', to: 'profile/dashboard#show'
    get 'profile/edit', to: 'profile/dashboard#edit'
    patch 'profile/', to: 'profile/dashboard#update'

    get '/profile/orders', to: 'profile/orders#index'
    get '/profile/orders/:id', to: 'profile/orders#show'
    patch '/profile/orders/:id', to: 'profile/orders#update'
  # end

  #admin_user
  # namespace :admin do
    get '/admin/', to: 'admin/dashboard#show'
    # resources :merchants, only: [:index, :show, :update]
    get '/admin/merchants', to: 'admin/merchants#index'
    get '/admin/merchants/:id', to: 'admin/merchants#show'
    patch '/admin/merchants/:id', to: 'admin/merchants#update'
    # resources :users, only: [:index, :show]
    get '/admin/users', to: 'admin/users#index'
    get '/admin/users/:id', to: 'admin/users#show'
  # end

  #merchant_user
  # namespace :merchant do
    get '/merchant/', to: 'merchant/dashboard#show'
    get '/merchant/orders/:id', to: 'merchant/orders#show'
    # resources :items, except: [:show]
    get '/merchant/items', to: 'merchant/items#index'
    post '/merchant/items', to: 'merchant/items#create'
    get '/merchant/items/new', to: 'merchant/items#new'
    get '/merchant/items/:id/edit', to: 'merchant/items#edit'
    patch '/merchant/items/:id', to: 'merchant/items#update'
    delete '/merchant/items/:id', to: 'merchant/items#destroy'
    # resources :item_orders, only: [:update]
    patch '/merchant/item_orders/:id', to: 'merchant/item_orders#update'
  # end
end
