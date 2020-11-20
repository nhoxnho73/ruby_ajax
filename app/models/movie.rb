require 'fileutils'
require 'csv'
require 'axlsx'

class Movie < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  accepts_nested_attributes_for :genre
  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment :image, 
                    content_type: { content_type: /\Aimage\/.*\z/ },
                    size: { less_than: 1.megabyte }

  delegate :email, to: :user
  scope :movie_name, ->(movie_name) { where("name LIKE ?", "%#{movie_name}%")}

  def movie_method
    "#{self.name}"
  end

  def genre_name
    return "" unless genre
    genre.name
  end

  def generate_file
    _folder_path = Pathname.new('/var/demo/movie/') + SecureRandom.hex(20)
    FileUtils.mkdir_p _folder_path
    _file_path = _folder_path + "#{release_date.to_s}.csv"
    _detail_file_path = _folder_path + "#{release_date.to_s}.zip"

    Dir.mktmpdir do |dir|
      _dir_path = Pathname.new dir
      Zip::File.open(_detail_file_path, Zip::File::CREATE) do |zipfile|
        CSV.open _file_path, 'wb' do |csv|
          csv << ['csv_type(MOVIE)', "Name", "Director", "Star", "Release date", "Summary"]
          Movie.all.each do |movie|
            month_str = "#{release_date.year}year#{release_date.day}month"
            csv << [
              # '20201',
              # "Movie_#{month_str}_web",
              # release_date.end_of_month.strftime('%Y/%m/%d'),
              # (release_date + 1).end_of_month.strftime('%Y/%m/%d'),
              # release_date.end_of_month.strftime('%Y/%m/%d'),
              movie.name,
              movie.director,
              movie.star,
              movie.release_date,
              movie.summary

            ]
          end
        end
      end
    end
    return _file_path, _detail_file_path
  end

end
