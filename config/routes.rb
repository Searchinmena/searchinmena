Rails.application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      passwords: "users/passwords",
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks"
    }

  get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth

  devise_scope :user do
    get "users", to: "registrations#new"
  end

  get "/home" => "pages#home", as: :home

  # TODO: remove it after finishing browsing feature
  get "/product" => "pages#product", as: :product

  root to: "pages#home"

  resources :tags, only: [:index]
  resources :units, only: [:index]
  resources :currencies, only: [:index]
  resources :frequencies, only: [:index]
  resources :payment_terms, only: [:index]
  resources :countries, only: [:index]
  resources :business_types, only: [:index]

  resource :company, only: [:create]
  resource :user

  resources :products, only: [:create, :index, :show, :destroy]
  resources :services, only: [:create, :index, :show, :destroy]
  resources :product_photos, only: [:create]
  resources :service_photos, only: [:create]
  resources :product_categories, only: [:index]
  resources :service_categories, only: [:index]
end
