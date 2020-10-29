class Movie::ZipMovies
  FILE_NAME = 'tmp'
  def self.perform files
    begin
      temp = Tempfile.new FILE_NAME
      Zip::File.open(temp.path, Zip::File::CREATE) do |zipfile|
        # files.each do |file|
        zipfile.add "#{files}", "#{files}"
        # end
      end
      # files.each do |file|
      #   File.delete "#{file}.xls"
      # end
    rescue Errno::ENOENT, IOError => e
      Rails.logger.error e.message
      temp.close
    end
    temp
  end

end
