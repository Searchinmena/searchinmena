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

ActiveRecord::Schema.define(version: 20150701133541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "name",            null: false
    t.string   "country",         null: false
    t.string   "phone",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         null: false
    t.integer  "year_registered"
    t.integer  "no_of_employees"
    t.string   "introduction"
  end

  add_index "businesses", ["user_id"], name: "index_businesses_on_user_id", unique: true, using: :btree

  create_table "businesses_business_types", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "business_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses_business_types", ["business_id", "business_type_id"], name: "index_businesses_business_types", unique: true, using: :btree

  create_table "businesses_tags", force: :cascade do |t|
    t.integer  "business_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "businesses_tags", ["business_id", "tag_id"], name: "index_businesses_tags_on_business_id_and_tag_id", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "key",        null: false
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "type",       null: false
  end

  add_index "categories", ["key"], name: "index_categories_on_key", unique: true, using: :btree
  add_index "categories", ["type"], name: "index_categories_on_type", using: :btree

  create_table "product_attributes", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_attributes", ["product_id"], name: "index_product_attributes_on_product_id", using: :btree

  create_table "product_photos", force: :cascade do |t|
    t.string   "photo",      null: false
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_photos", ["product_id"], name: "index_product_photos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "model_number"
    t.string   "brand_name"
    t.string   "description"
    t.integer  "category_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "min_order_quantity_number"
    t.string   "min_order_quantity_unit"
    t.decimal  "fob_price"
    t.string   "fob_price_currency"
    t.string   "fob_price_unit"
    t.string   "port"
    t.string   "payment_terms"
    t.integer  "supply_ability_capacity"
    t.string   "supply_ability_unit"
    t.string   "supply_ability_frequency"
    t.string   "packaging_details"
    t.integer  "business_id",               null: false
  end

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

  add_index "translatable", ["type"], name: "index_translatable_on_type", using: :btree

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
