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

ActiveRecord::Schema[8.1].define(version: 2026_05_02_163800) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_date"
    t.bigint "plan_id", null: false
    t.date "start_date"
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["plan_id"], name: "index_bookings_on_plan_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "program_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["program_id"], name: "index_enrollments_on_program_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "subject"
    t.datetime "updated_at", null: false
  end

  create_table "partnerships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "link"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.string "paystack_reference"
    t.bigint "plan_id"
    t.bigint "program_id"
    t.string "status"
    t.string "transaction_reference"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["plan_id"], name: "index_payments_on_plan_id"
    t.index ["program_id"], name: "index_payments_on_program_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "features"
    t.boolean "highlight"
    t.string "interval"
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "published_at"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_posts_on_slug"
  end

  create_table "programs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "duration"
    t.string "instructor"
    t.string "mode"
    t.decimal "price"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "project_applications", force: :cascade do |t|
    t.text "background"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "location"
    t.string "name"
    t.string "phone"
    t.bigint "project_id", null: false
    t.text "reason"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_applications_on_project_id"
  end

  create_table "project_partnerships", force: :cascade do |t|
    t.string "contact_person"
    t.datetime "created_at", null: false
    t.string "email"
    t.text "message"
    t.string "organization_name"
    t.string "partnership_type"
    t.string "phone"
    t.bigint "project_id", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_project_partnerships_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.text "about_description"
    t.text "about_quote"
    t.string "client"
    t.string "cost"
    t.datetime "created_at", null: false
    t.text "curriculum_description"
    t.string "curriculum_title"
    t.string "duration"
    t.string "format"
    t.text "hero_description"
    t.string "name"
    t.jsonb "partnership_bullets"
    t.text "partnership_description"
    t.string "partnership_title"
    t.string "reach"
    t.string "tagline"
    t.text "timeline_description"
    t.jsonb "timeline_steps"
    t.string "timeline_title"
    t.jsonb "tracks"
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.string "icon"
    t.decimal "pricing"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.text "bio"
    t.datetime "created_at", null: false
    t.string "name"
    t.string "role"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "plans"
  add_foreign_key "bookings", "users"
  add_foreign_key "enrollments", "programs"
  add_foreign_key "enrollments", "users"
  add_foreign_key "payments", "plans"
  add_foreign_key "payments", "programs"
  add_foreign_key "payments", "users"
  add_foreign_key "project_applications", "projects"
  add_foreign_key "project_partnerships", "projects"
end
