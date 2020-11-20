class Month
  def to_date
    Date.new year, number, 1
  end

  alias :beginning_of_month :to_date

  def end_of_month
    to_date.end_of_month
  end
end