class GenresController < ApplicationController
  before_action :authenticate_user!
  autocomplete :movie, :summary, label_method: :full_name, full_model: true
  before_action :set_params, only: [:show]
  def index
    @genres = Genre.all
    @movies = Movie.all
  end

  def show
    @movies = Movie.all
    set_params
  end

  def update_movie_list
    
    if params[:genre_id].present?
      @movies = Movie.where(genre_id: params[:genre_id]).group(:name)
    end
      
    render json: { movies:  @movies }
  end
  
  def search_movie_lists
    if params[:list_search].present? 
      @searchs = Movie.where("name IN (?) OR release_date IN (?) OR director IN (?) OR summary LIKE ?", params[:list_movie], params[:list_year], params[:list_keyword], "%#{params[:list_search]}%").uniq
    elsif  params[:list_movie].present? || params[:list_year].present? || params[:list_keyword].present
      @searchs = Movie.where("name IN (?) OR release_date IN (?) OR director IN (?)", params[:list_movie], params[:list_year], params[:list_keyword]).uniq
    end
    
    render json: { searchs: @searchs }
  end

  private

  def set_params
    @genre = Genre.find(params[:id])
  end

end