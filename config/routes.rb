Rails.application.routes.draw do

  namespace :public do
    get 'orders/new'
    get 'orders/create'

    get 'orders/show'
  end
  namespace :public do


    get 'addresses/create'

  end
  namespace :public do



  end
  namespace :admin do
    get 'order_items/update'
  end
  namespace :admin do
    get 'orders/show'
    get 'orders/update'
  end
  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end
  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:new, :index, :create, :show, :edit, :update]

  end

  namespace :public do

    get 'customers/update'

    get 'customers/withdraw'
  end

  root to: 'public/homes#top'
  get '/about' => 'public/homes#about'
  get '/customers/my_page' => 'public/customers#show'
  patch '/customers/my_page' => 'public/customers#update'
  get '/items' => 'public/items#index'
  get '/cart_items' => 'public/cart_items#index'
  post 'cart_items' => 'public/cart_items#create'
  delete 'cart_items' => 'public/cart_items#destroy', as: 'destroy_cart_items'
  delete 'cart_items' => 'public/cart_items#destroy_all', as: 'destroy_all_cart_items'
  patch 'cart_items/:id' => 'public/cart_items#update' , as: 'update_cart_item'
  get '/customers/information/edit' => 'public/customers#edit'
  get '/addresses' => 'public/addresses#index'
  post '/addresses' => 'public/addresses#create'
  get '/addresses/:id/edit' => 'public/addresses#edit', as: 'edit_address'
  delete '/addresses/:id' => 'public/addresses#destroy', as: 'destroy_address'
  patch '/addresses/:id/edit' => 'public/addresses#update'
  get '/orders' => 'public/orders#index'
  get '/customers/unsubscribe' => 'public/customers#unsubscribe'

  get '/items' => 'public/items#index', as: 'index_items'
  get '/items/:id' => 'public/items#show', as: 'show_items'

  namespace :public do
    get 'root_path' => 'public/homes#top'
    post '/customers' => 'registrations#create'




  end
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customer/sign_in ...
  devise_for :customer, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
