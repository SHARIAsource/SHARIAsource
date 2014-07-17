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

ActiveRecord::Schema.define(version: 20140717225727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborators", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collaborators", ["name"], name: "index_collaborators_on_name", using: :btree

  create_table "document_type_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "document_type_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "document_type_anc_des_udx", unique: true, using: :btree
  add_index "document_type_hierarchies", ["descendant_id"], name: "document_type_desc_idx", using: :btree

  create_table "document_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "document_types", ["name"], name: "index_document_types_on_name", using: :btree
  add_index "document_types", ["parent_id"], name: "index_document_types_on_parent_id", using: :btree

  create_table "era_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "era_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "era_anc_des_udx", unique: true, using: :btree
  add_index "era_hierarchies", ["descendant_id"], name: "era_desc_idx", using: :btree

  create_table "eras", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "eras", ["name"], name: "index_eras_on_name", using: :btree
  add_index "eras", ["parent_id"], name: "index_eras_on_parent_id", using: :btree

  create_table "region_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "region_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "region_anc_des_udx", unique: true, using: :btree
  add_index "region_hierarchies", ["descendant_id"], name: "region_desc_idx", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["name"], name: "index_regions_on_name", using: :btree
  add_index "regions", ["parent_id"], name: "index_regions_on_parent_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "themes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "themes", ["name"], name: "index_themes_on_name", using: :btree

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], name: "index_topics_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                      default: "",    null: false
    t.string   "encrypted_password",         default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",              default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                   default: false
    t.boolean  "is_editor",                  default: false
    t.boolean  "is_contributor",             default: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "last_name_without_articles"
    t.integer  "collaborator_id"
  end

  add_index "users", ["collaborator_id"], name: "index_users_on_collaborator_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_admin"], name: "index_users_on_is_admin", using: :btree
  add_index "users", ["is_contributor"], name: "index_users_on_is_contributor", using: :btree
  add_index "users", ["is_editor"], name: "index_users_on_is_editor", using: :btree
  add_index "users", ["last_name_without_articles"], name: "index_users_on_last_name_without_articles", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
