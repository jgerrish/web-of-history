# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140521045059) do

  create_table "event_groups", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_groups", ["name"], name: "index_event_groups_on_name", unique: true

  create_table "event_groups_historical_events", force: true do |t|
    t.integer  "event_group_id"
    t.integer  "historical_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_groups_historical_events", ["event_group_id", "historical_event_id"], name: "eghe_eghe_id", unique: true
  add_index "event_groups_historical_events", ["event_group_id"], name: "index_event_groups_historical_events_on_event_group_id"
  add_index "event_groups_historical_events", ["historical_event_id"], name: "index_event_groups_historical_events_on_historical_event_id"

  create_table "event_groups_maps", force: true do |t|
    t.integer  "event_group_id"
    t.integer  "map_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_groups_maps", ["event_group_id", "map_id"], name: "egm_egm_id", unique: true
  add_index "event_groups_maps", ["event_group_id"], name: "index_event_groups_maps_on_event_group_id"
  add_index "event_groups_maps", ["map_id"], name: "index_event_groups_maps_on_map_id"

  create_table "event_groups_shapefiles", force: true do |t|
    t.integer  "event_group_id"
    t.integer  "shapefile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_groups_shapefiles", ["event_group_id", "shapefile_id"], name: "egs_egs_id", unique: true
  add_index "event_groups_shapefiles", ["event_group_id"], name: "index_event_groups_shapefiles_on_event_group_id"
  add_index "event_groups_shapefiles", ["shapefile_id"], name: "index_event_groups_shapefiles_on_shapefile_id"

  create_table "historical_events", force: true do |t|
    t.integer  "historical_source_id"
    t.string   "title"
    t.string   "date_precision"
    t.date     "event_start_date"
    t.date     "event_end_date"
    t.text     "description"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "historical_events", ["historical_source_id"], name: "index_historical_events_on_historical_source_id"

  create_table "historical_events_historical_locations", force: true do |t|
    t.integer  "historical_event_id",    null: false
    t.integer  "historical_location_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "historical_events_historical_locations", ["historical_event_id", "historical_location_id"], name: "hehl_hehl_id", unique: true
  add_index "historical_events_historical_locations", ["historical_event_id"], name: "hehl_historical_event_id"
  add_index "historical_events_historical_locations", ["historical_location_id"], name: "hehl_historical_location_id"

  create_table "historical_events_shapefiles", force: true do |t|
    t.integer  "historical_event_id"
    t.integer  "shapefile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "historical_events_shapefiles", ["historical_event_id"], name: "index_historical_events_shapefiles_on_historical_event_id"
  add_index "historical_events_shapefiles", ["shapefile_id"], name: "index_historical_events_shapefiles_on_shapefile_id"

  create_table "historical_locations", force: true do |t|
    t.string   "name",       null: false
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "historical_sources", force: true do |t|
    t.string   "name"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "note"
  end

  create_table "maps", force: true do |t|
    t.string   "name",       null: false
    t.float    "center_lat"
    t.float    "center_lon"
    t.float    "zoom"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maps", ["name"], name: "index_maps_on_name", unique: true

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "shapefiles", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "shapefile"
    t.string   "shapefile_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
