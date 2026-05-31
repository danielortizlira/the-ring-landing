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

ActiveRecord::Schema[8.0].define(version: 2026_05_27_221715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "account_deletion_requests", force: :cascade do |t|
    t.string "email", null: false
    t.string "token", null: false
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_account_deletion_requests_on_token", unique: true
  end

  create_table "active_storage_attachments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.uuid "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "app_configs", force: :cascade do |t|
    t.string "minimum_version", default: "1.0.0", null: false
    t.string "latest_version", default: "1.0.0", null: false
    t.string "store_url_ios"
    t.string "store_url_android"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_es", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_es"], name: "index_categories_on_name_es", unique: true
  end

  create_table "categorizables", force: :cascade do |t|
    t.uuid "categorizable_id", null: false
    t.string "categorizable_type", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorizable_id", "categorizable_type", "category_id"], name: "idx_on_categorizable_id_categorizable_type_category_ad740588fd", unique: true
    t.index ["category_id"], name: "index_categorizables_on_category_id"
  end

  create_table "console_sessions", force: :cascade do |t|
    t.bigint "console_user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["console_user_id"], name: "index_console_sessions_on_console_user_id"
  end

  create_table "console_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_console_users_on_email", unique: true
  end

  create_table "equipment", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
    t.string "name_es"
  end

  create_table "exercise_equipments", force: :cascade do |t|
    t.uuid "exercise_id", null: false
    t.uuid "equipment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_exercise_equipments_on_equipment_id"
    t.index ["exercise_id"], name: "index_exercise_equipments_on_exercise_id"
  end

  create_table "exercises", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "muscle_group", default: 0
    t.string "name_en"
    t.string "name_es"
    t.text "instructions_en"
    t.text "instructions_es"
    t.integer "difficulty", default: 0, null: false
    t.integer "exercise_type", default: 0, null: false
    t.boolean "reviewed", default: false, null: false
  end

  create_table "muscle_groupables", force: :cascade do |t|
    t.uuid "muscle_groupable_id", null: false
    t.string "muscle_groupable_type", null: false
    t.bigint "muscle_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["muscle_group_id"], name: "index_muscle_groupables_on_muscle_group_id"
    t.index ["muscle_groupable_id", "muscle_groupable_type", "muscle_group_id"], name: "idx_on_muscle_groupable_id_muscle_groupable_type_mu_512ac86c98", unique: true
  end

  create_table "muscle_groups", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_es", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_es"], name: "index_muscle_groups_on_name_es", unique: true
  end

  create_table "newsletter_subscriptions", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_newsletter_subscriptions_on_email", unique: true
  end

  create_table "plan_days", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "plan_week_id", null: false
    t.uuid "workout_id", null: false
    t.integer "day_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_week_id", "day_index"], name: "index_plan_days_on_plan_week_id_and_day_index", unique: true
    t.index ["plan_week_id"], name: "index_plan_days_on_plan_week_id"
    t.index ["workout_id"], name: "index_plan_days_on_workout_id"
  end

  create_table "plan_weeks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "plan_id", null: false
    t.integer "week_index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description_en"
    t.text "description_es"
    t.index ["plan_id", "week_index"], name: "index_plan_weeks_on_plan_id_and_week_index", unique: true
    t.index ["plan_id"], name: "index_plan_weeks_on_plan_id"
  end

  create_table "plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
    t.string "name_es"
    t.text "description_en"
    t.text "description_es"
    t.integer "difficulty", default: 0, null: false
    t.boolean "featured", default: false, null: false
    t.string "entitlement_identifier"
    t.string "product_identifier"
  end

  create_table "sessions", force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "user_plans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "plan_id", null: false
    t.integer "active_week_index", default: 1, null: false
    t.integer "progress", default: 0
    t.datetime "completed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["completed_at", "plan_id", "user_id"], name: "index_user_plans_on_completed_at_and_plan_id_and_user_id", unique: true, where: "(completed_at IS NULL)"
    t.index ["plan_id"], name: "index_user_plans_on_plan_id"
    t.index ["user_id"], name: "index_user_plans_on_user_id"
  end

  create_table "user_workouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "workout_id", null: false
    t.datetime "completed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_plan_id"
    t.uuid "plan_day_id"
    t.integer "status", default: 0, null: false
    t.integer "rating"
    t.text "comment"
    t.integer "duration_in_seconds"
    t.index ["plan_day_id"], name: "index_user_workouts_on_plan_day_id"
    t.index ["user_id", "plan_day_id"], name: "index_user_workouts_on_user_id_and_plan_day_id", unique: true, where: "(status = 0)"
    t.index ["user_id"], name: "index_user_workouts_on_user_id"
    t.index ["user_plan_id"], name: "index_user_workouts_on_user_plan_id"
    t.index ["workout_id"], name: "index_user_workouts_on_workout_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email_verification_token"
    t.datetime "email_verification_sent_at"
    t.datetime "email_verified_at"
    t.integer "streak_count", default: 0, null: false
    t.date "last_workout_date"
    t.integer "preferred_difficulty"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email_verification_token"], name: "index_users_on_email_verification_token", unique: true
  end

  create_table "workout_phase_exercises", force: :cascade do |t|
    t.uuid "exercise_id", null: false
    t.uuid "workout_phase_id", null: false
    t.integer "effort", default: 0
    t.integer "effort_unit", default: 0
    t.integer "position", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exercise_id"], name: "index_workout_phase_exercises_on_exercise_id"
    t.index ["workout_phase_id"], name: "index_workout_phase_exercises_on_workout_phase_id"
  end

  create_table "workout_phases", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "workout_id", null: false
    t.integer "rounds"
    t.integer "rest", default: 0
    t.integer "rest_between_rounds", default: 0
    t.integer "rest_between_exercises", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.string "phase_name_en"
    t.string "phase_name_es"
    t.string "end_message_en"
    t.string "end_message_es"
    t.integer "gloves", default: 0
    t.index ["workout_id"], name: "index_workout_phases_on_workout_id"
  end

  create_table "workouts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
    t.string "name_es"
    t.text "description_en"
    t.text "description_es"
    t.integer "difficulty", default: 0, null: false
    t.boolean "featured", default: false, null: false
    t.integer "status", default: 0, null: false
    t.datetime "published_at"
    t.datetime "archived_at"
    t.string "entitlement_identifier"
    t.string "product_identifier"
    t.integer "estimated_duration_seconds"
    t.integer "intensity"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categorizables", "categories"
  add_foreign_key "console_sessions", "console_users"
  add_foreign_key "exercise_equipments", "equipment"
  add_foreign_key "exercise_equipments", "exercises"
  add_foreign_key "muscle_groupables", "muscle_groups"
  add_foreign_key "plan_days", "plan_weeks"
  add_foreign_key "plan_days", "workouts"
  add_foreign_key "plan_weeks", "plans"
  add_foreign_key "sessions", "users"
  add_foreign_key "user_plans", "plans"
  add_foreign_key "user_plans", "users"
  add_foreign_key "user_workouts", "plan_days"
  add_foreign_key "user_workouts", "user_plans"
  add_foreign_key "user_workouts", "users"
  add_foreign_key "user_workouts", "workouts"
  add_foreign_key "workout_phase_exercises", "exercises"
  add_foreign_key "workout_phase_exercises", "workout_phases"
  add_foreign_key "workout_phases", "workouts"
end
