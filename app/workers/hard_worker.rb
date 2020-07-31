class HardWorker
  include Sidekiq::Worker

  MAIL_MONTH = 1

  def perform movie
    case movie
    when MAIL_MONTH
      Movie.all.each do |movie|
        send_mail_when_end_month movie
      end
    end
  end

  private

  def send_mail_when_end_month movie
    UserMailer.user_month(movie).deliver_now
  end
end
