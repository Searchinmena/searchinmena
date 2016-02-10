Rails.application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users,
    controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions",
      passwords: "users/passwords",
      confirmations: "users/confirmations",
      omniauth_callbacks: "users/omniauth_callbacks"
    }

  get "omniauth/:provider" => "omniauth#localized", as: :localized_omniauth

  devise_scope :user do
    get "users", to: "registrations#new"
  end

  get "/home" => "pages#home", as: :home
  get "/about_us" => "pages#about_us", as: :about_us
  get "/contact_us" => "pages#contact_us", as: :contact_us
  get "/press" => "pages#press", as: :press
  get "/blog" => "pages#blog", as: :blog
  get "/faqs" => "pages#faqs", as: :faqs
  get "/careers" => "pages#careers", as: :careers
  get "/terms" => "pages#terms", as: :terms

  get "/home-1" => "landing_pages#home_one", as: :home_one

  root to: "pages#home"

  sitemap_path = "sitemaps/sitemap.xml.gz"
  aws_path = "https://#{A9n.aws[:bucket_name]}.s3.amazonaws.com/#{sitemap_path}"
  get '/sitemap.xml.gz', to: redirect(aws_path), as: :sitemap

  resources :tags, only: [:index]
  resources :units, only: [:index]
  resources :currencies, only: [:index]
  resources :frequencies, only: [:index]
  resources :payment_terms, only: [:index]
  resources :countries, only: [:index]
  resources :business_types, only: [:index]
  resources :business_tags, only: [:index]

  resources :businesses, only: [:show]
  resource :user_business, only: [:show, :update]
  resource :user

  resources :products, only: [:create, :index, :show, :destroy]
  resources :services, only: [:create, :index, :show, :destroy]
  resources :product_categories, only: [:index]
  resources :service_categories, only: [:index]
  resources :messages, only: [:create]

  get '/search' => "search#index", as: :search
end
