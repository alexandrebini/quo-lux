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

ActiveRecord::Schema.define(version: 9) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitors", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "product_id"], name: "index_competitors_on_group_id_and_product_id"
    t.index ["product_id", "group_id"], name: "index_competitors_on_product_id_and_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["product_id"], name: "index_groups_on_product_id"
    t.index ["slug"], name: "index_groups_on_slug", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "asin", null: false
    t.string "title"
    t.integer "price"
    t.string "images", default: [], null: false, array: true
    t.string "features", default: [], null: false, array: true
    t.integer "reviews_count"
    t.integer "rank"
    t.integer "inventory"
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.datetime "last_fetch_at"
    t.integer "last_fetch_status", default: 0, null: false
    t.text "last_fetch_log"
    t.index ["asin"], name: "index_products_on_asin", unique: true
    t.index ["last_fetch_status"], name: "index_products_on_last_fetch_status"
    t.index ["price"], name: "index_products_on_price"
    t.index ["rank"], name: "index_products_on_rank"
    t.index ["reviews_count"], name: "index_products_on_reviews_count"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["status"], name: "index_products_on_status"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.datetime "created_at"
    t.jsonb "object"
    t.jsonb "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
