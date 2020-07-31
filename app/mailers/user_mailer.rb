class UserMailer < ApplicationMailer
  
  def user_month movie
    @user = movie.user

    mail(to: @user.email, subject: "welcome to movie web!")
  end
end
