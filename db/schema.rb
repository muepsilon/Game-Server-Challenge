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

ActiveRecord::Schema.define(version: 20161014193007) do

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "gameid",     limit: 255, null: false
  end

  create_table "grids", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "game_id",    limit: 4
    t.text     "text",       limit: 65535, null: false
  end

  add_index "grids", ["game_id"], name: "fk_rails_b42e42914d", using: :btree

  create_table "move_sequences", force: :cascade do |t|
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.float    "score",      limit: 24,  default: 0.0, null: false
    t.string   "word",       limit: 255
    t.integer  "player_id",  limit: 4
    t.integer  "game_id",    limit: 4
  end

  add_index "move_sequences", ["game_id"], name: "fk_rails_4d3b3ef5dd", using: :btree
  add_index "move_sequences", ["player_id"], name: "fk_rails_ec6b5e00d6", using: :btree

  create_table "players", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "playerid",   limit: 255,                 null: false
    t.float    "points",     limit: 24,  default: 0.0,   null: false
    t.boolean  "admin",                  default: false, null: false
    t.integer  "game_id",    limit: 4
  end

  add_index "players", ["game_id"], name: "fk_rails_d71756309d", using: :btree

  create_table "words", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "word",       limit: 255, null: false
    t.integer  "grid_id",    limit: 4
  end

  add_index "words", ["grid_id"], name: "fk_rails_08e94ee5bd", using: :btree

  add_foreign_key "grids", "games"
  add_foreign_key "move_sequences", "games"
  add_foreign_key "move_sequences", "players"
  add_foreign_key "players", "games"
  add_foreign_key "words", "grids"
end
