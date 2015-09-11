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

ActiveRecord::Schema.define(version: 20150911161930) do

  create_table "board_games", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "title"
    t.string   "creator"
    t.string   "image"
    t.text     "description"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "min_time"
    t.integer  "max_time"
    t.float    "bgg_score"
    t.boolean  "expansion"
    t.string   "expansion_to"
  end

  create_table "expansions", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "creator"
    t.string   "image"
    t.text     "description"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "min_time"
    t.integer  "max_time"
    t.integer  "bgg_score"
  end

end
