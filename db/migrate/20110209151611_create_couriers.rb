class CreateCouriers < ActiveRecord::Migration
  def self.up
    create_table :couriers do |t|
      t.string :email
      t.string :phone
      t.string :username
      t.string :password
      t.decimal :max_volume
      t.decimal :max_mass
      t.boolean :available
      t.string :transport_mode
      t.decimal :cost_per_distance
      t.decimal :cost_per_distance_per_mass
      t.decimal :cost_per_distance_per_volume
      t.datetime :last_coordinate_update_time
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end

  def self.down
    drop_table :couriers
  end
end
