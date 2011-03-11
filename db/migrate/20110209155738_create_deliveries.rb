class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.string :pickup_address
      t.string :pickup_name
      t.string :dropoff_address
      t.string :dropoff_name
      t.integer :number_of_packages
      t.decimal :mass
      t.decimal :volume
      t.decimal :cost
      t.datetime :delivery_due
      t.boolean :successfully_delivered
      t.integer :waypoint_order
      t.decimal :lat, :precision => 9, :scale => 6
      t.decimal :lng, :precision => 9, :scale => 6
      t.integer :courier_id
      t.integer :search_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
