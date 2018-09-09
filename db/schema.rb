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

ActiveRecord::Schema.define(version: 2018_09_09_145916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "raider_io_pull"
    t.string "name"
    t.string "realm"
    t.string "region"
    t.integer "raider_io_score"
    t.integer "item_level"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.datetime "start"
    t.datetime "expire"
    t.integer "instance"
    t.text "description"
    t.integer "min_raider_io_score"
    t.integer "min_item_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "battletag"
    t.string "email"
    t.string "password"
    t.string "access_code"
    t.string "phone"
    t.boolean "verified"
    t.jsonb "settings", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "discord_id"
  end

end
