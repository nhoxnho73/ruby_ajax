namespace :sidekiq do
  sidekiq_pid_file = Rails.root + 'tmp/pids/sidekiq.pid'

  desc 'Start sidekiq'
  task :start do
    puts "Starting Sidekiq..."
    system "bundle exec sidekiq -e #{Rails.env} -C config/sidekiq.yml -P tmp/pids/sidekiq.pid -d -L log/sidekiq.log" # starts sidekiq process here
    sleep 2
    puts "Sidekiq started #PID-#{File.readlines(sidekiq_pid_file).first.chomp}."
  end

  desc 'Stop sidekiq'
  task :stop do
    puts "#### Trying to stop Sidekiq Now !!! ####"
    if File.exist?(sidekiq_pid_file)
      puts "Stopping sidekiq now #PID-#{File.readlines(sidekiq_pid_file).first.chomp}..."
      system "sidekiqctl stop tmp/pids/sidekiq.pid 3600" # stops sidekiq process here
    else
      puts "--- Sidekiq Not Running !!!"
    end
  end

  desc 'Restart sidekiq'
  task :restart do
    puts "#### Trying to restart Sidekiq Now !!! ####"
    Rake::Task['sidekiq:stop'].invoke
    Rake::Task['sidekiq:start'].invoke
    puts "#### Sidekiq restarted successfully !!! ####"
  end
end
