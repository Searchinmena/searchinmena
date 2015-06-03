Rails.application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  devise_for :users,
    skip: [:session, :password, :registration, :confirmation],
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)", locale: /en|ar/ do
    get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth

    devise_for :users, skip: [:omniauth_callbacks], controllers: {
      registrations: "registrations"
    }

    devise_scope :user do
      get "users", to: "registrations#new"
    end

    get "/home" => "pages#home", as: :home
    resource :dashboard, controller: :dashboard

    root to: "pages#home"
  end
end
