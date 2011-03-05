class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.decimal :min_volume
      t.decimal :min_mass
      t.string :transport_mode
      t.decimal :total_cost_less_than
      t.datetime :last_coordinate_update_time_greater_than
      t.string :pickup_address
      t.integer :max_distance
      t.datetime :delivery_due

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
