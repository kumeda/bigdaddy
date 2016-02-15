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

ActiveRecord::Schema.define(version: 20160215063858) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "county_id"
  end

  add_index "cities", ["county_id"], name: "index_cities_on_county_id", using: :btree

  create_table "counties", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
  end

  add_index "counties", ["state_id"], name: "index_counties_on_state_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "spot_id"
    t.string   "image"
  end

  add_index "reports", ["spot_id"], name: "index_reports_on_spot_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "spots", force: :cascade do |t|
    t.string   "name",             null: false
    t.string   "yelp_url",         null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "latitude"
    t.float    "longitude"
    t.string   "display_address"
    t.integer  "yelp_business_id"
    t.integer  "city_id"
    t.string   "yelp_image_url"
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "two_digit_code", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "description",                  null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "icon_image"
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.integer  "city_id"
  end

  add_index "users", ["city_id"], name: "index_users_on_city_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  create_table "zips", force: :cascade do |t|
    t.integer  "code",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "city_id"
    t.integer  "spot_id"
  end

  add_index "zips", ["city_id"], name: "index_zips_on_city_id", using: :btree

end
