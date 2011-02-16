# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110210002440) do

  create_table "couriers", :force => true do |t|
    t.string   "email"
    t.string   "phone"
    t.string   "username"
    t.string   "password"
    t.decimal  "max_volume"
    t.decimal  "max_mass"
    t.boolean  "available"
    t.string   "transport_mode"
    t.decimal  "cost_per_distance"
    t.decimal  "cost_per_distance_per_mass"
    t.decimal  "cost_per_distance_per_volume"
    t.datetime "last_coordinate_update_time"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries", :force => true do |t|
    t.string   "pickup_address"
    t.string   "pickup_name"
    t.string   "dropoff_address"
    t.string   "dropoff_name"
    t.integer  "number_of_packages"
    t.decimal  "mass"
    t.decimal  "volume"
    t.decimal  "cost"
    t.datetime "delivery_due"
    t.integer  "courier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.decimal  "min_volume"
    t.decimal  "min_mass"
    t.string   "transport_mode"
    t.decimal  "total_cost_less_than"
    t.datetime "last_coordinate_update_time_greater_than"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "max_distance"
  end

end
