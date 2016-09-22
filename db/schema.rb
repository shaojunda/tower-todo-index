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

ActiveRecord::Schema.define(version: 20160922063906) do

  create_table "assignments", force: :cascade do |t|
    t.integer  "origin_executor_id"
    t.integer  "new_executor_id"
    t.datetime "origin_deadline"
    t.datetime "new_deadline"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "todo_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "todo_id"
    t.integer  "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "creator_id"
    t.string   "action"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "ownerable_id"
    t.string   "ownerable_type"
    t.integer  "team_id"
    t.index ["eventable_id", "eventable_type"], name: "index_events_on_eventable_id_and_eventable_type"
    t.index ["ownerable_id", "ownerable_type"], name: "index_events_on_ownerable_id_and_ownerable_type"
  end

  create_table "project_permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_type", default: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "team_id"
  end

  create_table "team_permissions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "todos", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "description"
    t.integer  "todoable_id"
    t.string   "todoable_type"
    t.string   "aasm_state",    default: "todo_created"
    t.integer  "user_id"
    t.index ["aasm_state"], name: "index_todos_on_aasm_state"
    t.index ["todoable_id", "todoable_type"], name: "index_todos_on_todoable_id_and_todoable_type"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "user_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
