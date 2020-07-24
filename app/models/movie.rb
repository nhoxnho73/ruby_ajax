class Movie < ApplicationRecord
  belongs_to :genre
  accepts_nested_attributes_for :genre

  def movie_method
    "#{self.name}"
  end

  def genre_name
    return "" unless genre
    genre.name
  end
end
