# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151013095428) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "animals", force: :cascade do |t|
    t.string   "name"
    t.text     "blurb"
    t.text     "guidelines"
    t.string   "ext_url"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "active",             default: true, null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "dog_statuses", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "status",      default: 0, null: false
    t.text     "guidelines",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "dog_statuses", ["location_id"], name: "index_dog_statuses_on_location_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.datetime  "created_at",                                                                                 null: false
    t.datetime  "updated_at",                                                                                 null: false
    t.integer   "category",                                                                    default: 0,    null: false
    t.integer   "region",                                                                                     null: false
    t.string    "name",                                                                                       null: false
    t.text      "animal_blurb",                                                                               null: false
    t.geography "geolocation",        limit: {:srid=>4326, :type=>"point", :geographic=>true},                null: false
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.datetime  "image_updated_at"
    t.boolean   "active",                                                                      default: true, null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer   "location_id"
    t.integer   "animal_id"
    t.text      "blurb",                                                                       default: "No description"
    t.geography "geolocation",        limit: {:srid=>4326, :type=>"point", :geographic=>true},                            null: false
    t.datetime  "created_at",                                                                                             null: false
    t.datetime  "updated_at",                                                                                             null: false
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.datetime  "image_updated_at"
  end

  add_index "reports", ["animal_id"], name: "index_reports_on_animal_id", using: :btree
  add_index "reports", ["location_id"], name: "index_reports_on_location_id", using: :btree

  add_foreign_key "dog_statuses", "locations"
  add_foreign_key "reports", "animals"
  add_foreign_key "reports", "locations"
end
