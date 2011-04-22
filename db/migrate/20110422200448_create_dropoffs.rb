class CreateDropoffs < ActiveRecord::Migration
  def self.up
    create_table :dropoffs do |t|
      t.string :dropoff_address
      t.string :dropoff_name
      t.datetime :dropoff_due
      t.decimal :lat, :precision => 9, :scale => 6
      t.decimal :lng, :precision => 9, :scale => 6
      t.integer :courier_id
      t.integer :delivery_id

      t.timestamps
    end
  end

  def self.down
    drop_table :dropoffs
  end
end
