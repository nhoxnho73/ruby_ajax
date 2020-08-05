require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, "development"
set :output, "#{Rails.root}/log/cron.log"
set :chronic_options, hours24: true
every :day, at: '0:00', roles: [:app] do
  runner 'ScheduleTask.logrotate'
end
every "0 0 1 * *" do
  rake "send_mail_user_movie:usermonth"
end

every '0 9 11,12,13,14 * *', roles: [:db] do
  runner 'ScheduleTask.export_csv'
end
