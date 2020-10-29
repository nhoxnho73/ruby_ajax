class Plans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.integer :kisses
    
      t.timestamps
    end
    
  end
end
