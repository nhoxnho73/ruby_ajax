require 'axlsx'
require 'zip'
class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :set_params, only: [:destroy, :show, :edit, :update]

  def index
    
    if current_user.present?
      @movies = current_user.movies.paginate(page: params[:page], per_page: 5)
    end

  end

  def download_pdf
    date = Date.today.strftime '%Y%m%d'
    respond_to do |format|
      format.html
      format.pdf do
        @movies = Movie.all
        pdf = ExportReport.new(view_context, @movies)

        send_data pdf.render, filename: "Movie_list_#{date}.pdf",
          type: "application/pdf"
      end 
    end
  end
  

  def detail_zip
    @movie  = Movie.all
    respond_to do |format|
      format.html
      format.zip do
        compressed_filestream = Zip::OutputStream.write_buffer do |zos|
          content = render_to_string xlsx: 'export', filename: dowload
          zos.put_next_entry(dowload)
          zos.print content
        end
        compressed_filestream.rewind
        send_data compressed_filestream.read, filename: "movies.zip"
      end
    end
  end

  def dowload
    movies = current_user.movies.all
    date = Date.today.strftime '%Y%m%d'
    Axlsx::Package.new do |package|
      package.workbook do |wb|
        default = {sz: 12, alignment: {horizontal: :left, vertical: :center}}
        default_style    = wb.styles.add_style default
        stt_style        = wb.styles.add_style default.merge({alignment: {horizontal: :center, vertical: :center}})
        movie_name_style = wb.styles.add_style default.merge({border: {style: :thin, color: '170DD7', edges: [:top, :bottom]}})
        star_movie_style = wb.styles.add_style default.merge({bg_color: 'C0C0C0', alignment: {horizontal: :center, vertical: :center}})
        wb.add_worksheet(name: "#{date}_moves") do |sheet|
          sheet.add_row ["STT", "ID", "Name", "Director", "Star", "Release date", "Summary"], style: [nil, nil, nil, nil, star_movie_style, nil, movie_name_style]
          movies.each_with_index do |movie, i|
            sheet.add_row [i+1, movie.id, movie.name, movie.director, movie.star, movie.release_date, movie.summary], style: [nil, nil, nil, nil, star_movie_style, nil, movie_name_style]
          end
        end
      end

      Dir.mktmpdir do |dir|
        xlsx_path = dir + "#{date}_movie_web.xlsx"
        package.serialize xlsx_path
  
        respond_to do |format|
          format.all { send_file xlsx_path }
        end
      end
    end
  end

  def new 
    @genres = Genre.all
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id

    if @movie.save!
      MovieMailer.with(movie: @movie).new_movie_email.deliver_later
      redirect_to movies_path(@movie)
      flash[:info] = "create #{@movie.name} successfull"
    else
      flash[:info] = "create movie faile"
    end

  end

  def show
    set_params
  end

  def edit
    @genres = Genre.all
    set_params
  end

  def update
    @movie.update! movie_params
    @movie.update!(genre_id: params[:genre_id])
    redirect_to movies_path

  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  private

  def set_params
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:name, :genre_id, :director, :star, :release_date, :summary, :user_id, :image)
  end

end


