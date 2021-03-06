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

ActiveRecord::Schema.define(version: 2019_08_27_140832) do

  create_table "infos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "station1", null: false
    t.string "longitude_latitude1", null: false
    t.string "station2", null: false
    t.string "longitude_latitude2", null: false
    t.string "route1", null: false
    t.string "route2"
    t.string "route3"
    t.string "route4"
    t.string "day", null: false
    t.string "push_time", null: false
    t.string "line_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "push_time2"
  end

end
