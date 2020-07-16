class GenresController < ApplicationController
  autocomplete :movie, :summary, label_method: :full_name, full_model: true

  def index
    @genres = Genre.all
    @movies = Movie.all
  end

  def update_movie_list
    
    if params[:genre_id].present?
      @movies = Movie.where(genre_id: params[:genre_id]).all

    end
      
    render json: { movies:  @movies }
  end
  
  def search_movie_lists
    
    @searchs = Movie.where("name IN (?) OR release_date IN (?) OR director IN (?) OR summary LIKE ?", params[:list_movie], params[:list_year], params[:list_keyword], "%#{params[:list_search]}%")

    render json: { searchs: @searchs }
  end


end