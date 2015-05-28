Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  scope "(:locale)", :locale => /en|ar/ do
    devise_for :users, controllers: {
      registrations: "registrations"
    }

    get "/home" => "pages#home", as: :home
    get "/dashboard" => "dashboard#dashboard_home", as: :dashboard_home

    root to: "pages#home"
  end
end
