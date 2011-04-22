class CreatePickups < ActiveRecord::Migration
  def self.up
    create_table :pickups do |t|
      t.string :pickup_address
      t.string :pickup_name
      t.datetime :pickup_after
      t.decimal :lat, :precision => 9, :scale => 6
      t.decimal :lng, :precision => 9, :scale => 6
      t.integer :courier_id
      t.integer :delivery_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pickups
  end
end
