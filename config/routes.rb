Rails.application.routes.draw do
  root to: "static_pages#index"
  resources :users, only: [:new, :create, :edit, :update]

  get "/login"  => "sessions#new"
  post "/login"  => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get "/tickets" => "events#index"
  get "/tickets/new" => "items#new", as: 'new_ticket'
  post "/tickets/new" => "items#create", as: nil
  get "/random_event" => "events#random", as: 'random_event'

  get "/admin" => "admin#index"


  resources :venues, only: [:show]

  get "/cart" => "cart_items#index"
  post "/cart" => "cart_items#create"
  post "/remove_item" => "cart_items#destroy"
  post "/update_item" => "cart_items#update"

  resources :events, only: [:show]
  resources :orders, only: [:show, :new, :create, :index]

  scope "admin", module: "admin", as: "admin" do
    post "/orders/:status" => "orders#filter", as: "filter_order"
    put "/orders/:id" => "orders#update", as: "update_order"
    get "/orders/:status" => "orders#filter", as: "order"

    resources :categories
    resources :events
    resources :venues

    resources :items, only: [:index, :new, :create, :edit, :update]
    delete "/items/:id" => "items#void_item", as: "void_item"
    post "/items/:id" => "items#unvoid_item", as: "unvoid_item"

    resources :users, only: [:index, :show]
    get "/users/:id/suspend" => "users#suspend_user", as: "suspend_user"
    get "/users/:id/unsuspend" => "users#unsuspend_user", as: "unsuspend_user"
  end


  scope "/:slug", module: "seller", as: "seller" do
    get "/store" => "users#show", as: "store"
    get "/dashboard" => "users#index", as: "dashboard"
    resources :items, only: [:edit, :destroy, :update]
    resources :orders, only: [:index, :show]
  end

  get "*rest" => "static_pages#not_found"
end
