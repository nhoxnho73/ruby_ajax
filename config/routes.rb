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

  resources :movies 
  resources :genres do
    collection { post :import }
    get :autocomplete_movie_summary, :on => :collection
  end

  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
