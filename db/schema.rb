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

ActiveRecord::Schema.define(version: 20160104212524) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "friends", force: :cascade do |t|
    t.string   "username"
    t.string   "name"
    t.text     "bio"
    t.string   "website"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "uid"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "instagram_avatar_url"
  end

  add_index "friends", ["uid"], name: "index_friends_on_uid"
  add_index "friends", ["username"], name: "index_friends_on_username"

  create_table "results", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "like_count",  default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "total_count", default: 0
  end

  add_index "results", ["friend_id"], name: "index_results_on_friend_id"
  add_index "results", ["user_id"], name: "index_results_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "avatar"
    t.text     "bio"
    t.string   "website"
    t.string   "auth_token"
    t.boolean  "has_results",              default: false
    t.string   "share_image_url"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "share_image_file_name"
    t.string   "share_image_content_type"
    t.integer  "share_image_file_size"
    t.datetime "share_image_updated_at"
    t.boolean  "shared"
    t.boolean  "popular",                  default: false
  end

  add_index "users", ["shared"], name: "index_users_on_shared"

end
