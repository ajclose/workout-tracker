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

ActiveRecord::Schema.define(version: 20171113185814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "amrapmovements", force: :cascade do |t|
    t.bigint "amrap_id"
    t.string "rx_movement"
    t.integer "rx_reps"
    t.integer "rx_weight"
    t.string "rx_unit"
    t.string "scaled_movement"
    t.integer "scaled_reps"
    t.integer "scaled_weight"
    t.string "scaled_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amrap_id"], name: "index_amrapmovements_on_amrap_id"
  end

  create_table "amraps", force: :cascade do |t|
    t.bigint "workout_id"
    t.string "time"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "additional_reps"
    t.text "notes"
    t.string "name"
    t.index ["workout_id"], name: "index_amraps_on_workout_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "rftmovements", force: :cascade do |t|
    t.bigint "rft_id"
    t.string "rx_movement"
    t.integer "rx_reps"
    t.integer "rx_weight"
    t.string "rx_unit"
    t.string "scaled_movement"
    t.integer "scaled_reps"
    t.integer "scaled_weight"
    t.string "scaled_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rft_id"], name: "index_rftmovements_on_rft_id"
  end

  create_table "rfts", force: :cascade do |t|
    t.bigint "workout_id"
    t.string "score"
    t.integer "rounds"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.string "name"
    t.index ["workout_id"], name: "index_rfts_on_workout_id"
  end

  create_table "strengths", force: :cascade do |t|
    t.bigint "workout_id"
    t.string "movement"
    t.integer "sets"
    t.integer "reps"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes"
    t.index ["workout_id"], name: "index_strengths_on_workout_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "workouts", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workouts_on_user_id"
  end

  add_foreign_key "amrapmovements", "amraps"
  add_foreign_key "amraps", "workouts"
  add_foreign_key "rftmovements", "rfts"
  add_foreign_key "rfts", "workouts"
  add_foreign_key "strengths", "workouts"
  add_foreign_key "workouts", "users"
end
