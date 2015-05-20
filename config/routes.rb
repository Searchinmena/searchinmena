Rails.application.routes.draw do
  devise_for :users, controllers: { 
              registrations: "registrations"
  }
  get "/home" => "pages#home", as: :home

  root to: "pages#home"
end
