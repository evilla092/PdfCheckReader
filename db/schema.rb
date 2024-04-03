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

ActiveRecord::Schema[7.0].define(version: 2024_04_03_015941) do
  create_table "checks", force: :cascade do |t|
    t.date "check_date", null: false
    t.decimal "check_amount", null: false
    t.integer "infraction_count", default: 0
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employer_id", null: false
    t.index ["employer_id"], name: "index_checks_on_employer_id"
    t.index ["user_id"], name: "index_checks_on_user_id"
  end

  create_table "employers", force: :cascade do |t|
    t.string "name"
    t.decimal "dues_rate", precision: 5, scale: 2
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "infractions", force: :cascade do |t|
    t.integer "payer_id"
    t.string "note"
    t.boolean "passed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payer_id"], name: "index_infractions_on_payer_id"
  end

  create_table "payers", force: :cascade do |t|
    t.decimal "dues_amount"
    t.decimal "cope_amount"
    t.string "name"
    t.decimal "total_wages_earned_pp"
    t.decimal "hourly_rate"
    t.integer "check_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_payers_on_check_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "department"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "checks", "employers"
  add_foreign_key "checks", "users"
  add_foreign_key "employers", "users"
  add_foreign_key "infractions", "payers"
  add_foreign_key "payers", "checks"
end
