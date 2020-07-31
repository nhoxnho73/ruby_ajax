class CreateMovieJob < ApplicationJob
  queue_as :movie

  def perform(movie_id)
    movie = Movie.find movie_id

    return movie
  end
end
