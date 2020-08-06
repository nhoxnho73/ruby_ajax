class GenresController < ApplicationController
  before_action :authenticate_user!
  autocomplete :movie, :summary
  before_action :set_params, only: [:show]
  def index
    @genres = Genre.all
    @movies = Movie.all
  end

  def new 
    @genre = Genre.new
  end

  def import
    Genre.import(params[:file])
    redirect_to root_path, notice: "Imported."
  end

  def create
    @genre = Genre.create(genre_params)
    if @genre.save!
      flash[:infor] = "create genre successfull"
      redirect_to genres_path
    else
      flash[:alert] = "create genre fails"
    end
  end

  def show
    @movies = Movie.all.paginate(page: params[:page], per_page: 5)
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

  def autocomplete_movie_summary
    movies = Movie.where('summary LIKE ?', "%#{params[:search_summary_movie]}%").group(:summary).order(:summary).all
    render :json => movies.map { |movie| {:id => movie.id, :label => movie.summary, :value => movie.summary} }
  end

  private

  def set_params
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end

end