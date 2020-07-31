class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_params, only: [:destroy, :show, :edit, :update]

  def index
    
    # binding.pry
    # @movies = Movie.where(user_id: current_user.id)
    if current_user.present?
      @movies = current_user.movies
    end
    # binding.pry
    
  end

  def new 
    @genres = Genre.all
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id

    if @movie.save!
      MovieMailer.with(movie: @movie).new_movie_email.deliver_later
      redirect_to movies_path(@movie)
      flash[:info] = "create #{@movie.name} successfull"
    else
      flash[:info] = "create movie faile"
    end

  end

  def show
    set_params
  end

  def edit
    @genres = Genre.all
    set_params
  end

  def update
    @movie.update(movie_params)
    redirect_to movies_path

  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_params
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :genre_id, :director, :star, :release_date, :summary, :user_id)
  end


end


