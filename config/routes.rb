Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  devise_for :users,
    skip: [:session, :password, :registration, :confirmation],
    controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)", locale: /en|ar/ do
    devise_for :users, skip: [:omniauth_callbacks], controllers: {
      registrations: "registrations"
    }

    get "/home" => "pages#home", as: :home
    get "/dashboard" => "dashboard#dashboard_home", as: :dashboard_home

    root to: "pages#home"
  end
end
