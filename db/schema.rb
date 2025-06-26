# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_23_064825) do
  create_table "ai_models", force: :cascade do |t|
    t.string "model"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ai_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "ai_model_id", null: false
    t.index ["ai_model_id"], name: "index_ai_users_on_ai_model_id"
    t.index ["user_id"], name: "index_ai_users_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
  end

  create_table "notice_settings", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "like_enable", default: true, null: false
    t.boolean "repost_enable", default: true, null: false
    t.boolean "quote_enable", default: true, null: false
    t.boolean "reply_enable", default: true, null: false
    t.boolean "follow_enable", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notice_settings_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "notifiable_type", null: false
    t.bigint "notifiable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_hide", default: false, null: false
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "content", limit: 280
    t.string "status", default: "published"
    t.bigint "reply_to_id"
    t.integer "likes_count", default: 0, null: false
    t.integer "replies_count", default: 0, null: false
    t.integer "reposts_count", default: 0, null: false
    t.bigint "quoted_post_id"
    t.integer "quotes_count", default: 0, null: false
    t.index ["quoted_post_id"], name: "index_posts_on_quoted_post_id"
    t.index ["reply_to_id"], name: "index_posts_on_reply_to_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "self_introduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.bigint "quoted_post_id", null: false
    t.bigint "quoting_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quoted_post_id"], name: "index_quotes_on_quoted_post_id"
    t.index ["quoting_post_id"], name: "index_quotes_on_quoting_post_id"
  end

  create_table "replies", force: :cascade do |t|
    t.bigint "parent_post_id", null: false
    t.bigint "child_post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_post_id"], name: "index_replies_on_child_post_id"
    t.index ["parent_post_id"], name: "index_replies_on_parent_post_id"
  end

  create_table "reposts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "post_id"], name: "index_reposts_on_user_id_and_post_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "email", null: false
    t.string "image"
    t.string "password_digest"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "ai_users", "ai_models"
  add_foreign_key "ai_users", "users"
  add_foreign_key "follows", "users", column: "followed_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "notices", "users"
  add_foreign_key "posts", "posts", column: "quoted_post_id"
  add_foreign_key "posts", "posts", column: "reply_to_id"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "quotes", "posts", column: "quoted_post_id"
  add_foreign_key "quotes", "posts", column: "quoting_post_id"
  add_foreign_key "replies", "posts", column: "child_post_id"
  add_foreign_key "replies", "posts", column: "parent_post_id"
end
