require 'prawn'
require 'prawn/table'

class ExportReport < Prawn::Document
  include Prawn::View

  def initialize(view, movies)
    super()
    @view = view 
    @movies = movies

    movie_line_items
    
  end

  def movie_line_items
    move_down 20
    table movie_item_rows do
      self.row_colors = ["DDDDDD", "FFFFFF"]
      row(0).font_style = :bold
      row(0).font_size = 
      column(0).align = :center
      column(1).align = :left
      columns(2..5).align = :center
      # row(0).width = 
      self.header = true
    end
  end

  def movie_item_rows
    # text "ID"
    # text "\n"
    # text "Director"
    # text "\n"
    # text "Star"
    # text "\n"
    # text "Release_date"
    # text "\n"
    # text "Summary"
    # text "\n"
    [["ID", "Name", "Director", "Star", "Release date", "Summary"]] +
    @movies.map do |item|
      [item.id, item.name, item.director,
        item.star, item.release_date, item.summary]
    end
  end

end
