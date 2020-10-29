require 'fileutils'

class Movie < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  accepts_nested_attributes_for :genre
  has_attached_file :image, styles: { medium: "300x300", thumb: "100x100" }
  validates_attachment :image, 
                    content_type: { content_type: /\Aimage\/.*\z/ },
                    size: { less_than: 1.megabyte }

  delegate :email, to: :user

  def movie_method
    "#{self.name}"
  end

  def genre_name
    return "" unless genre
    genre.name
  end

  def target_month
    Month.parse super
  end

  def target_month=(value)
    if value.is_a?(Month)
      super value.to_s
    else
      super value
    end
  end

  def self.generate_file movies
    _folder_path = Pathname.new('/var/movie_web/movie/') + SecureRandom.hex(20)
    FileUtils.mkdir_p _folder_path, :mode => 02750
    _file_path = _folder_path + ".csv"
    _detail_file_path = _folder_path + ".zip"

    Dir.mktmpdir do |dir|
      _dir_path = Pathname.new dir
      Zip::File.open(_detail_file_path, Zip::File::CREATE) do |zipfile|
        CSV.open _file_path, 'wb' do |csv|
          csv << ['csv_type(MOVIE)', "ID", "Name", "Director", "Star", "Release date", "Summary"]
          movies.each do |movie|
            month_str = "#{target_month.year}year#{target_month.number}month"
            billing_number = "S#{sprintf('%02d', target_month.number)}#{target_month.year}1#{sprintf('%05', movie.id)}"

            csv << [
              '20201',
              "Movie_#{month_str}_web",
              target_month.end_of_month.strftime('%Y/%m/%d'),
              (target_month + 1).end_of_month.strftime('%Y/%m/%d'),
              target_month.end_of_month.strftime('%Y/%m/%d'),
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
