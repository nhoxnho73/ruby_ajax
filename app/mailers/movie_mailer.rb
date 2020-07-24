class MovieMailer < ApplicationMailer

  def new_movie_email
    @movie = params[:movie]

    mail(to: "admin@movie.com", subject: "You got a new movie!")
  end
  
end