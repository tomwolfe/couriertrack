class CreateDistances < ActiveRecord::Migration
  def self.up
    create_table :distances do |t|
      t.decimal :est_distance
      t.decimal :est_cost
      t.datetime :est_time
      t.integer :courier_id
      t.integer :search_id

      t.timestamps
    end
  end

  def self.down
    drop_table :distances
  end
end
