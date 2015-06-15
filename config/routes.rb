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

  resource :dashboard, controller: :dashboard

  root to: "pages#home"

  namespace :api do
    resources :tags, only: [:index]
    resources :products, only: [:create]
  end
end
