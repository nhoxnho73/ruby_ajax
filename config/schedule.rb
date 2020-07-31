require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, "development"
set :output, "#{Rails.root}/log/cron.log"
set :chronic_options, hours24: true

every "0 0 1 * *" do
  rake "send_mail_user_movie:usermonth"
end
