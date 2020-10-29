class WatchMoviesController < MoviesController

  def index
    if current_user.present?
      @movies = current_user.movies.paginate(page: params[:page], per_page: 5)
    end
  end

end