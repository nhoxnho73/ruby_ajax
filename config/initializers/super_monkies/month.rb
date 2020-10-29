class Date
  def to_month
    Month.new year, month
  end

  def near_work_day
    0.business_day.after self
  end
end