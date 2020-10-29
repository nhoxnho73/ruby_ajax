require File.expand_path(File.dirname(__FILE__) + "/environment")
rails_env = ENV['RAILS_ENV'] || :development
set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
set :chronic_options, hours24: true

every :day, at: '0:00', roles: [:app] do
  runner 'ScheduleTask.logrotate'
end

every "0 9 * * *" do
  rake "send_mail_user_movie:usermonth"
end

every '* 9 * * *', roles: [:db] do
  runner 'ScheduleTask.export_csv'
end

every '* 9 * * *', roles: [:db] do
  runner 'ScheduleTask.export_file_csv'
end
