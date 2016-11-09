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

ActiveRecord::Schema.define(version: 20161026121615) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "service_id"
    t.integer  "user_id"
    t.string   "name",       null: false
    t.string   "url",        null: false
    t.string   "login",      null: false
    t.string   "password",   null: false
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_accounts_on_service_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "accounts_projects", id: false, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "project_id", null: false
    t.index ["account_id", "project_id"], name: "index_accounts_projects_on_account_id_and_project_id"
    t.index ["project_id", "account_id"], name: "index_accounts_projects_on_project_id_and_account_id"
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                       null: false
    t.boolean  "banned",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
    t.index ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id"
    t.index ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",                    null: false
    t.string   "url",                     null: false
    t.string   "login_button_identifier", null: false
    t.string   "login_field_identifier",  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "full_name",                                        null: false
    t.string   "login",                                            null: false
    t.string   "email",                            default: "",    null: false
    t.string   "origin_password",                                  null: false
    t.string   "position",                                         null: false
    t.integer  "role",                   limit: 1,                 null: false
    t.boolean  "banned",                           default: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_statistics", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "project_id", null: false
    t.datetime "start_at",   null: false
    t.datetime "end_at"
    t.index ["project_id"], name: "index_work_statistics_on_project_id"
    t.index ["user_id"], name: "index_work_statistics_on_user_id"
  end

end
