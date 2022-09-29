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

ActiveRecord::Schema[7.0].define(version: 2022_09_29_105026) do
  create_table "cells", force: :cascade do |t|
    t.integer "world_id", null: false
    t.integer "x"
    t.integer "y"
    t.boolean "alive", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["world_id"], name: "index_cells_on_world_id"
  end

  create_table "generations", force: :cascade do |t|
    t.integer "simulation_id", null: false
    t.integer "number", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["simulation_id"], name: "index_generations_on_simulation_id"
  end

  create_table "simulations", force: :cascade do |t|
    t.integer "generations_count", default: 0, null: false
    t.datetime "running_at"
    t.datetime "latest_run_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "generation_repeating_count", default: 0
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

  create_table "worlds", force: :cascade do |t|
    t.integer "generation_id", null: false
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["generation_id"], name: "index_worlds_on_generation_id"
  end

  add_foreign_key "cells", "worlds"
  add_foreign_key "generations", "simulations"
  add_foreign_key "worlds", "generations"
end
