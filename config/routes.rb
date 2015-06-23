Rails.application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  devise_for :users,
    skip: [:session, :password, :registration, :confirmation],
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth

  devise_for :users, skip: [:omniauth_callbacks], controllers: {
    registrations: "registrations",
    sessions: "sessions"
  }

  devise_scope :user do
    get "users", to: "registrations#new"
  end

  get "/home" => "pages#home", as: :home
  get "/browse" => "pages#browse", as: :browse
  get "/results" => "pages#results", as: :results

  resource :dashboard, controller: :dashboard

  root to: "pages#home"

  resources :tags, only: [:index]
  resources :units, only: [:index]
  resources :currencies, only: [:index]
  resources :frequencies, only: [:index]
  resources :payment_terms, only: [:index]

  resources :products, only: [:create]
  resources :product_photos, only: [:create]
end
