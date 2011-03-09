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

ActiveRecord::Schema.define(:version => 20110223085756) do

  create_table "couriers", :force => true do |t|
    t.string   "email"
    t.string   "phone"
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.decimal  "max_volume",                   :precision => 10, :scale => 0
    t.decimal  "max_mass",                     :precision => 10, :scale => 0
    t.boolean  "available"
    t.string   "transport_mode"
    t.decimal  "cost_per_distance",            :precision => 10, :scale => 0
    t.decimal  "cost_per_distance_per_mass",   :precision => 10, :scale => 0
    t.decimal  "cost_per_distance_per_volume", :precision => 10, :scale => 0
    t.datetime "last_coordinate_update_time"
    t.decimal  "current_volume",               :precision => 10, :scale => 0, :default => 0
    t.decimal  "current_mass",                 :precision => 10, :scale => 0, :default => 0
    t.decimal  "avail_volume",                 :precision => 10, :scale => 0
    t.decimal  "avail_mass",                   :precision => 10, :scale => 0
    t.decimal  "lat",                          :precision => 9,  :scale => 6
    t.decimal  "lng",                          :precision => 9,  :scale => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deliveries", :force => true do |t|
    t.string   "pickup_address"
    t.string   "pickup_name"
    t.string   "dropoff_address"
    t.string   "dropoff_name"
    t.integer  "number_of_packages"
    t.decimal  "mass",                   :precision => 10, :scale => 0
    t.decimal  "volume",                 :precision => 10, :scale => 0
    t.decimal  "cost",                   :precision => 10, :scale => 0
    t.datetime "delivery_due"
    t.boolean  "successfully_delivered"
    t.integer  "waypoint_order"
    t.decimal  "lat",                    :precision => 9,  :scale => 6
    t.decimal  "lng",                    :precision => 9,  :scale => 6
    t.integer  "courier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "search_courier", :force => true do |t|
    t.decimal  "est_distance", :precision => 10, :scale => 0
    t.decimal  "est_cost",     :precision => 10, :scale => 0
    t.datetime "est_time"
    t.integer  "courier_id"
    t.integer  "search_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.decimal  "min_volume",                               :precision => 10, :scale => 0
    t.decimal  "min_mass",                                 :precision => 10, :scale => 0
    t.string   "transport_mode"
    t.decimal  "total_cost_less_than",                     :precision => 10, :scale => 0
    t.datetime "last_coordinate_update_time_greater_than"
    t.string   "pickup_address"
    t.integer  "max_distance"
    t.datetime "delivery_due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
