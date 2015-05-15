Rails.application.routes.draw do
  get "/home" => "pages#home", as: :home

  root to: "pages#home"
end
