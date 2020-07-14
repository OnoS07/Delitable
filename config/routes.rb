Rails.application.routes.draw do
  # 顧客側devise
  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
    post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
    delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  end

  # 管理者側devise
  devise_for :customers, skip: :all
  devise_scope :customer do
    get 'customers/sign_in' => 'customers/sessions#new', as: 'new_customer_session'
    post 'customers/sign_in' => 'customers/sessions#create', as: 'customer_session'
    delete 'customers/sign_out' => 'customers/sessions#destroy', as: 'destroy_customer_session'
    get 'customers/sign_up' => 'customers/registrations#new', as: 'new_customer_registration'
    post 'customers' => 'customers/registrations#create', as: 'customer_registration'
  end

  # EC顧客側ルーティング
  root 'homes#top'
  get '/' => 'homes#top', as: 'top'
  get 'home/about' => 'homes#about', as: 'about'

  resource :customers, only: [:hoge] do
    resources :shippings, only: %i[index edit update create destroy]
    resources :orders, only: %i[index show new create]
    resources :cart_items, only: %i[update create destroy]
  end
  get 'customers/delete' => 'customers#delete', as: 'customers_delete'

  resources :customers, only: %i[show edit update destroy]
  get 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  get 'orders/complete' => 'orders#complete', as: 'order_complete'
  get 'cart_items/confirm' => 'cart_items#confirm', as: 'cart_item_confirm'
  delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'


  resources :products, only: %i[index show]

  # EC管理者側ルーティイング
  namespace :admins do
    resources :products, only: %i[index show new create edit update]
    resources :customers, only: %i[index show edit update]
    resources :orders, only: %i[index show update]
    get '/' => 'orders#top', as: 'top'
    resources :order_details, only: [:update]
    resources :genres, only: %i[index edit create update destroy]
  end

  # SNSルーティング
  resources :recipes do
    resources :ingredient, only: %i[edit update]
    resources :step, only: %i[edit update]
    resource :post_comments, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end
    get 'ingredient' => 'recipes#ingredient', as: 'new_ingredient'
    get 'step' => 'steps#process', as: 'new_step'
end
