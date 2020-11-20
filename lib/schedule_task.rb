module ScheduleTask
  def self.export_csv
    before_day = Date.today - 10
    Movie.where(release_date: before_day).where(created_at: before_day.beginning_of_day..before_day.end_of_day).each do |movie|
      movie.gennerate_file!
    end
  end
  
  def self.export_file_csv
    Movie.all.each do |movie|
      movie.gennerate_file!
    end
  end
end
