namespace :send_mail_user_movie do
  desc "DEMO"
  task usermonth: :environment do
    HardWorker.perform_async HardWorker::MAIL_MONTH
  end
end