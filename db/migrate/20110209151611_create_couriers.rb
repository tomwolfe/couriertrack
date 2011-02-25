class CreateCouriers < ActiveRecord::Migration
  def self.up
    create_table :couriers do |t|
      t.string :email
      t.string :phone
      t.string :username
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.decimal :max_volume
      t.decimal :max_mass
      t.boolean :available
      t.string :transport_mode
      t.decimal :cost_per_distance
      t.decimal :cost_per_distance_per_mass
      t.decimal :cost_per_distance_per_volume
      t.datetime :last_coordinate_update_time
      t.decimal :lat, :precision => 9, :scale => 6
      t.decimal :lng, :precision => 9, :scale => 6

      t.timestamps
    end
  end

  def self.down
    drop_table :couriers
  end
end
