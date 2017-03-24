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

ActiveRecord::Schema.define(version: 20170322072839) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "bookings", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "cleaner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "city_id"
    t.datetime "datetime"
  end

  add_index "bookings", ["city_id"], name: "index_bookings_on_city_id"
  add_index "bookings", ["cleaner_id"], name: "index_bookings_on_cleaner_id"
  add_index "bookings", ["customer_id"], name: "index_bookings_on_customer_id"

  create_table "cities", force: :cascade do |t|
    t.string   "city_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities_cleaners", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "cleaner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities_cleaners", ["city_id"], name: "index_cities_cleaners_on_city_id"
  add_index "cities_cleaners", ["cleaner_id"], name: "index_cities_cleaners_on_cleaner_id"

  create_table "cleaners", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "quality_score"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email"
  end

  create_table "cleaners_cities", force: :cascade do |t|
    t.integer  "city_id"
    t.integer  "cleaner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cleaners_cities", ["city_id"], name: "index_cleaners_cities_on_city_id"
  add_index "cleaners_cities", ["cleaner_id"], name: "index_cleaners_cities_on_cleaner_id"

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "password"
  end

end
