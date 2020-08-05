class AddImageToMovies < ActiveRecord::Migration[5.2]
  def change
    change_table :movies do |t|
      t.attachment :image
    end
  end
end
