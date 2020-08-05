module ScheduleTask
  def self.export_csv
    target_month = (Date.today.to_month - 1).to_s
    before_day = Day.today - 10
    Movie.where(release_date: before_day).where(created_at: before_day.beginning_of_day..before_day.end_of_day).each do |movie|
      movie.gennerate_file!
    end
  end
  
end
