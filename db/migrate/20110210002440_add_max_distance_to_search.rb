class AddMaxDistanceToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :max_distance, :decimal
  end

  def self.down
    remove_column :searches, :max_distance
  end
end
