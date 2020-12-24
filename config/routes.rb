Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: "sessions"}

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "movies#index"

  get "/update_movie_list" => "genres#update_movie_list"
  get "/search_movie_lists" => "genres#search_movie_lists"
  get "/dowloads" => "movies#dowload"
  get "/detail_zips" => "movies#detail_zip"
  get "/download_pdfs" => "movies#download_pdf"
  get "/paypal/checkout", to: "subscriptions#paypal_checkout"

  resources :movies 
  resources :rooms 

  resources :messages
  resources :genres do
    collection { post :import }
    get :autocomplete_movie_summary, :on => :collection
  end
  resources :watch_movies
  resources :locations do
    resources :appointments, only: [:index, :show, :new]
  end
  resources :appointments
  resources :clients do
    resources :appointments, only: [:index, :show, :new]
  end
  get '/locations/:id/client_list', to: 'locations#client_list', as: 'client_list'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable' #kich hoat actioncable
end
