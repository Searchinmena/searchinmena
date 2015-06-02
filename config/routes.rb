Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  scope "(:locale)", locale: /en|ar/ do
    devise_for :users, controllers: {
      registrations: "registrations"
    }
    devise_scope :user do
      get "users", to: "registrations#new"
    end

    get "/home" => "pages#home", as: :home

    resource :dashboard, controller: :dashboard

    root to: "pages#home"
  end

  namespace :api do
    resources :tags, only: [:index]
  end
end
