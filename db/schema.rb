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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121118042251) do

  create_table "game_players", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "game_players", ["game_id"], :name => "index_game_players_on_game_id"
  add_index "game_players", ["player_id"], :name => "index_game_players_on_player_id"

  create_table "games", :force => true do |t|
    t.integer  "location_id"
    t.date     "on"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "games", ["location_id"], :name => "index_games_on_location_id"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "places", :force => true do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "places", ["game_id"], :name => "index_places_on_game_id"
  add_index "places", ["player_id"], :name => "index_places_on_player_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "nickname"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
