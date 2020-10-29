class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, :limit => 255
      t.string :phone_number, :limit => 255
      t.string :email, :limit => 255
      t.integer :user_id, :limit => 4
      
      t.timestamps
    end
  end
end
