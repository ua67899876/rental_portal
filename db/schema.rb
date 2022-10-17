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

ActiveRecord::Schema.define(version: 2022_10_14_204844) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.integer "apartment_type", default: 0, null: false
    t.decimal "rent", precision: 8, scale: 2, default: "0.0", null: false
    t.string "location", default: "", null: false
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_apartments_on_owner_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "requester_id", null: false
    t.bigint "moderator_id", null: false
    t.bigint "apartment_id", null: false
    t.datetime "start_at"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apartment_id"], name: "index_appointments_on_apartment_id"
    t.index ["moderator_id"], name: "index_appointments_on_moderator_id"
    t.index ["requester_id"], name: "index_appointments_on_requester_id"
  end

  create_table "deeds", force: :cascade do |t|
    t.integer "deed_type", default: 0, null: false
    t.date "starts_on", null: false
    t.date "ends_on", null: false
    t.bigint "apartment_id"
    t.bigint "owner_id", null: false
    t.bigint "renter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apartment_id"], name: "index_deeds_on_apartment_id"
    t.index ["owner_id"], name: "index_deeds_on_owner_id"
    t.index ["renter_id"], name: "index_deeds_on_renter_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.integer "user_type", default: 0, null: false
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apartments", "users", column: "owner_id"
  add_foreign_key "appointments", "apartments"
  add_foreign_key "appointments", "users", column: "moderator_id"
  add_foreign_key "appointments", "users", column: "requester_id"
  add_foreign_key "deeds", "apartments"
  add_foreign_key "deeds", "users", column: "owner_id"
  add_foreign_key "deeds", "users", column: "renter_id"
end
