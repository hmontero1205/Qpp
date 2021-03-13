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

ActiveRecord::Schema.define(version: 20210311152217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", id: :bigserial, force: :cascade do |t|
    t.string   "name",        null: false
    t.string   "record_type", null: false
    t.bigint   "record_id",   null: false
    t.bigint   "blob_id",     null: false
    t.datetime "created_at",  null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id", using: :btree
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true, using: :btree
  end

  create_table "active_storage_blobs", id: :bigserial, force: :cascade do |t|
    t.string   "key",          null: false
    t.string   "filename",     null: false
    t.string   "content_type"
    t.text     "metadata"
    t.string   "service_name", null: false
    t.bigint   "byte_size",    null: false
    t.string   "checksum",     null: false
    t.datetime "created_at",   null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true, using: :btree
  end

  create_table "active_storage_variant_records", id: :bigserial, force: :cascade do |t|
    t.bigint "blob_id",          null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true, using: :btree
  end

  create_table "office_hours", force: :cascade do |t|
    t.string   "host"
    t.string   "class_name"
    t.datetime "time"
    t.string   "zoom_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email"
  end

  create_table "queue_entries", force: :cascade do |t|
    t.text     "student"
    t.datetime "start_time"
    t.text     "description"
    t.integer  "oh_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "surname"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
