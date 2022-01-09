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

ActiveRecord::Schema.define(version: 2022_01_07_231704) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "owner_id"], name: "index_accounts_on_name_and_owner_id", unique: true
  end

  create_table "alimentations", force: :cascade do |t|
    t.datetime "date", null: false
    t.bigint "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_alimentations_on_account_id"
    t.index ["meal_id"], name: "index_alimentations_on_meal_id"
  end

  create_table "alimentations_foods", force: :cascade do |t|
    t.decimal "value", precision: 6, scale: 2, null: false
    t.bigint "alimentation_id", null: false
    t.bigint "food_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alimentation_id", "food_id"], name: "index_alimentations_foods_on_alimentation_id_and_food_id", unique: true
    t.index ["alimentation_id"], name: "index_alimentations_foods_on_alimentation_id"
    t.index ["food_id"], name: "index_alimentations_foods_on_food_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "unit_id"
    t.string "ancestry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_exams_on_ancestry"
    t.index ["name", "ancestry"], name: "index_exams_on_name_and_ancestry", unique: true
    t.index ["unit_id"], name: "index_exams_on_unit_id"
  end

  create_table "exams_references", force: :cascade do |t|
    t.string "gender"
    t.decimal "minimum_age", precision: 6, scale: 3
    t.decimal "maximum_age", precision: 6, scale: 3
    t.decimal "minimum_value", precision: 10, scale: 2
    t.decimal "maximum_value", precision: 10, scale: 2
    t.boolean "default", default: false, null: false
    t.bigint "exam_id", null: false
    t.bigint "reference_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_exams_references_on_exam_id"
    t.index ["reference_id"], name: "index_exams_references_on_reference_id"
  end

  create_table "exams_results", force: :cascade do |t|
    t.decimal "value", precision: 10, scale: 2, null: false
    t.bigint "exam_id", null: false
    t.bigint "result_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id", "result_id"], name: "index_exams_results_on_exam_id_and_result_id", unique: true
    t.index ["exam_id"], name: "index_exams_results_on_exam_id"
    t.index ["result_id"], name: "index_exams_results_on_result_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.string "measure", null: false
    t.decimal "amount", precision: 5, scale: 2
    t.decimal "cho", precision: 5, scale: 2, null: false
    t.decimal "kcal", precision: 6, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "measure"], name: "index_foods_on_name_and_measure", unique: true
  end

  create_table "heights", force: :cascade do |t|
    t.date "date", null: false
    t.integer "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_heights_on_account_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "account_id", null: false
    t.datetime "accepted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_invitations_on_account_id"
    t.index ["email", "account_id"], name: "index_invitations_on_email_and_account_id", unique: true
  end

  create_table "meals", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_meals_on_name", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "user_id"], name: "index_memberships_on_account_id_and_user_id", unique: true
    t.index ["account_id"], name: "index_memberships_on_account_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "references", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_references_on_name", unique: true
  end

  create_table "results", force: :cascade do |t|
    t.date "date", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_results_on_account_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_units_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email", default: "", null: false
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false, null: false
    t.string "gender"
    t.date "date_of_birth"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "weights", force: :cascade do |t|
    t.datetime "date", null: false
    t.decimal "value", precision: 5, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "account_id", null: false
    t.index ["account_id"], name: "index_weights_on_account_id"
  end

  add_foreign_key "accounts", "users", column: "owner_id"
  add_foreign_key "alimentations", "accounts"
  add_foreign_key "alimentations", "meals"
  add_foreign_key "alimentations_foods", "alimentations"
  add_foreign_key "alimentations_foods", "foods"
  add_foreign_key "exams", "units"
  add_foreign_key "exams_references", "\"references\"", column: "reference_id"
  add_foreign_key "exams_references", "exams"
  add_foreign_key "exams_results", "exams"
  add_foreign_key "exams_results", "results"
  add_foreign_key "heights", "accounts"
  add_foreign_key "invitations", "accounts"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
  add_foreign_key "results", "accounts"
  add_foreign_key "weights", "accounts"
end
