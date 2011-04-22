class CreateDeliveries < ActiveRecord::Migration
  def self.up
    create_table :deliveries do |t|
      t.integer :number_of_packages
      t.decimal :mass
      t.decimal :volume
      t.decimal :cost
      t.boolean :successfully_delivered
      t.integer :courier_id
      t.integer :search_id

      t.timestamps
    end
  end

  def self.down
    drop_table :deliveries
  end
end
