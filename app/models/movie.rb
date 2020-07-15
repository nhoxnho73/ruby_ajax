class Movie < ApplicationRecord
  belongs_to :genre

  def movie_method
    "#{self.name}"
  end
end
