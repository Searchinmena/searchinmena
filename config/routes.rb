Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations"
  }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get "/home" => "pages#home", as: :home
  get "/dashboard" => "dashboard#dashboard_home", as: :dashboard_home

  root to: "pages#home"
end
