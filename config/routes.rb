Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations"
  }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  get "/home" => "pages#home", as: :home

  resource :dashboard, controller: :dashboard

  root to: "pages#home"
end
