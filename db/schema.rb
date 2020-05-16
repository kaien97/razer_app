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

ActiveRecord::Schema.define(version: 2020_05_16_165635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "name"
    t.integer "n_pax"
    t.float "cost"
    t.float "paid"
    t.string "status"
    t.string "participant_list", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.bigint "business_id"
    t.bigint "personal_account_id"
    t.datetime "timing"
    t.index ["business_id"], name: "index_activities_on_business_id"
    t.index ["personal_account_id"], name: "index_activities_on_personal_account_id"
  end

  create_table "business_accounts", force: :cascade do |t|
    t.float "money"
    t.bigint "user_id"
    t.string "hash_id"
    t.string "mambu_user_id"
    t.string "mambu_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_business_accounts_on_user_id"
  end

  create_table "businesses", force: :cascade do |t|
    t.integer "postal_code"
    t.string "service"
    t.string "name"
    t.string "address"
    t.integer "price_max"
    t.integer "price_min"
    t.jsonb "info", default: {}
    t.string "phone_number"
    t.string "hash_id"
    t.bigint "business_account_id"
    t.string "timings_available"
    t.index ["business_account_id"], name: "index_businesses_on_business_account_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "cal_type"
    t.string "cal_url"
    t.jsonb "auth_info", default: {}
    t.bigint "businesses_id"
    t.bigint "personal_accounts_id"
    t.index ["businesses_id"], name: "index_calendars_on_businesses_id"
    t.index ["personal_accounts_id"], name: "index_calendars_on_personal_accounts_id"
  end

  create_table "identities", force: :cascade do |t|
    t.string "encrypted_idnum"
    t.string "encrypted_dob"
    t.string "encrypted_name"
    t.string "encrypted_race"
    t.string "encrypted_country"
    t.datetime "issue_date"
    t.datetime "end_date"
    t.string "id_type"
    t.boolean "verified", default: false
    t.string "temp_image_front"
    t.string "temp_image_back"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.bigint "personal_account_id"
    t.index ["personal_account_id"], name: "index_identities_on_personal_account_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "loaner_hash_id"
    t.integer "lender_hash_id"
    t.boolean "settled", default: false
    t.jsonb "history", default: {}
    t.string "hash_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lender_hash_id"], name: "index_loans_on_lender_hash_id"
    t.index ["loaner_hash_id", "lender_hash_id"], name: "index_loans_on_loaner_hash_id_and_lender_hash_id", unique: true
    t.index ["loaner_hash_id"], name: "index_loans_on_loaner_hash_id"
  end

  create_table "personal_accounts", force: :cascade do |t|
    t.float "money"
    t.integer "credit_score"
    t.bigint "user_id"
    t.string "hash_id"
    t.string "mambu_user_id"
    t.string "mambu_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_personal_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hash_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "business_accounts", "users", on_delete: :cascade
  add_foreign_key "businesses", "business_accounts", on_delete: :cascade
  add_foreign_key "calendars", "businesses", column: "businesses_id", on_delete: :cascade
  add_foreign_key "calendars", "personal_accounts", column: "personal_accounts_id", on_delete: :cascade
  add_foreign_key "identities", "personal_accounts", on_delete: :cascade
  add_foreign_key "personal_accounts", "users", on_delete: :cascade
end
