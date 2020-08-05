require 'csv'
class Genre < ApplicationRecord
  has_many :movies

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Genre.create!(row.to_hash)
    end
  end

end
