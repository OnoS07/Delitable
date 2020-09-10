Rails.application.routes.draw do
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'customers/registrations#create', as: 'customer_registration'
  end
  post '/homes/guest_sign_in', to: 'homes#new_guest'
  post '/homes/admin_sign_in', to: 'homes#new_admin'

  root 'homes#top'
  get '/' => 'homes#top', as: 'top'
  get 'home/about' => 'homes#about', as: 'about'

  # @customer = current_customerのため、customer/:id が不要なネスト
  resource :customers, only: [:hoge] do
    resources :shippings, only: %i[index edit update create destroy]
    resources :orders, only: %i[index show new create]
    resources :cart_items, only: %i[update create destroy]
  end
  get 'customers/delete' => 'customers#delete', as: 'customers_delete'

  # どのユーザーか(customer/:id)が必要なネスト
  resources :customers, only: %i[show edit update destroy] do
    resource :relationships, only: %i[create destroy]
    get 'follows' => 'relationships#follows', as: 'follows'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get 'customer/:id/favorite_index' => 'customers#favorite_index', as: 'favorites'
  get 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  get 'orders/complete' => 'orders#complete', as: 'order_complete'
  get 'cart_items/confirm' => 'cart_items#confirm', as: 'cart_item_confirm'
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'

  resources :products, only: %i[index show] do
    resources :reviews, only: %i[create destroy]
  end

  namespace :admins do
    resources :products, only: %i[index show new create edit update]
    get 'reviews' => 'products#reviews', as: 'reviews'
    resources :customers, only: %i[index show edit update]
    resources :orders, only: %i[index show update]
    get '/' => 'orders#top', as: 'top'
    resources :order_details, only: [:update]
    resources :genres, only: %i[index edit create update destroy]

    resources :recipes, only: %i[index show edit update destroy] do
      resources :ingredients, only: %i[edit update destroy]
      resources :cookings, only: %i[edit update destroy]
      resources :comments, only: [:destroy]
    end
  end

  resources :recipes do
    resources :ingredients, only: %i[update create destroy]
    resources :cookings, only: %i[update create destroy]
    resources :comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
    resource :ingredients, only: %i[edit]
    resource :cookings, only: %i[edit]
  end

  patch 'recipe/:id/sort_cooking', to: 'recipes#sort_cooking'
  patch 'recipe/:id/sort_ingredient', to: 'recipes#sort_ingredient'
end
