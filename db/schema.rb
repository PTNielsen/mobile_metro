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

ActiveRecord::Schema.define(version: 20150702182020) do

  create_table "bikeshares", force: :cascade do |t|
    t.string   "name"
    t.float    "bikeshare_latitude"
    t.float    "bikeshare_longitude"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "metrobuses", force: :cascade do |t|
    t.string   "stop_name"
    t.string   "stop_code"
    t.float    "stop_latitude"
    t.float    "stop_longitude"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "station_code"
    t.string   "station_name"
    t.string   "line_1"
    t.string   "line_2"
    t.string   "line_3"
    t.string   "line_4"
    t.float    "station_latitude"
    t.float    "station_longitude"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
