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

ActiveRecord::Schema.define(version: 20150610123118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attributes", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "country",       null: false
    t.string   "phone",         null: false
    t.integer  "business_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",       null: false
  end

  add_index "businesses", ["user_id"], name: "index_businesses_on_user_id", unique: true, using: :btree

  create_table "businesses_tags", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses_tags", ["business_id", "tag_id"], name: "index_businesses_tags_on_business_id_and_tag_id", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "url",        null: false
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "model_number"
    t.string   "brand_name"
    t.string   "description"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "min_order_quantity_number"
    t.string   "min_order_quantity_unit"
    t.integer  "FOB_price"
    t.string   "FOB_price_type"
    t.string   "FOB_price_unit"
    t.string   "port"
    t.string   "payment_terms"
    t.integer  "supply_abbility_number"
    t.string   "supply_abbility_type"
    t.string   "supply_abbility_capacity"
    t.string   "packaging_details"
  end

  create_table "products_categories", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "products_categories", ["product_id", "category_id"], name: "index_products_categories_on_product_id_and_category_id", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "translatable", force: :cascade do |t|
    t.string   "key"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: :cascade do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
