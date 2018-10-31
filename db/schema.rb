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

ActiveRecord::Schema.define(version: 2018_10_30_225558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "key", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "name", null: false
    t.text "homepage"
    t.text "description"
    t.string "logo_id"
    t.string "owner_id", null: false
    t.integer "permissions", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "client_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "grant_id", null: false
    t.string "scopes", default: [], null: false, array: true
    t.datetime "expires_at", null: false
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_id"], name: "index_tokens_on_grant_id"
  end

  create_table "user_assertion_ids", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "assertion", null: false
    t.integer "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source", "assertion"], name: "index_user_assertion_ids_on_source_and_assertion", unique: true
  end

  create_table "user_names", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "name", null: false
    t.integer "status", default: 1, null: false
    t.integer "kind", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_names_on_name", unique: true
  end

  create_table "user_passwords", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "password", null: false
    t.integer "source", default: 0, null: false
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "grants", "clients"
  add_foreign_key "tokens", "grants"
end
