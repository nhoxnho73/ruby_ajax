Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "genres#index"
  get "/update_movie_list" => "genres#update_movie_list"
  get "/search_movie_lists" => "genres#search_movie_lists"
  resources :movies
  resources :genres do
    get :autocomplete_movie_summary, :on => :collection
  end
    # collection do
      
    # end
end
