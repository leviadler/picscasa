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

ActiveRecord::Schema.define(version: 20140624201825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.string   "title",       null: false
    t.text     "description"
    t.date     "date"
    t.string   "location"
    t.integer  "owner_id"
    t.integer  "visibility"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["owner_id"], name: "index_albums_on_owner_id", using: :btree

  create_table "photos", force: true do |t|
    t.text     "caption"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_token"], name: "index_sessions_on_session_token", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "fname",           null: false
    t.string   "lname",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
