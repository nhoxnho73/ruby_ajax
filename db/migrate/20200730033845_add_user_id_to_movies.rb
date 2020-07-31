class AddUserIdToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :user_id, :bigint
  end
end
