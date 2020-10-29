class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :appointment_time
      t.integer :duration, :limit => 4
      t.float :price, :limit => 24
      t.integer :location_id, :limit => 4
      t.integer :user_id, :limit => 4
      t.integer :client_id, :limit => 4

      t.timestamps
    end
  end
end
