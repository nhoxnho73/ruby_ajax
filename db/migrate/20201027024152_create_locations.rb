class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :nickname, :limit => 255
      t.string :city, :limit => 255
      t.string :street_address, :limit => 255
      t.string :state, :limit => 255
      t.string :zipcode, :limit => 255
      t.string :business_name, :limit => 255
      t.integer :user_id, :limit => 4
      
      t.timestamps
    end
  end
end
