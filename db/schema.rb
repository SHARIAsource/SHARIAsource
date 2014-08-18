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

ActiveRecord::Schema.define(version: 20140818184258) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodies", force: true do |t|
    t.text    "text"
    t.integer "page_id"
    t.integer "commentary_id"
  end

  add_index "bodies", ["commentary_id"], name: "index_bodies_on_commentary_id", unique: true, using: :btree
  add_index "bodies", ["page_id"], name: "index_bodies_on_page_id", using: :btree

  create_table "collaborators", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "collaborators", ["name"], name: "index_collaborators_on_name", using: :btree

  create_table "commentaries", force: true do |t|
    t.string   "title"
    t.integer  "contributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "counter_cache",  default: 0
  end

  add_index "commentaries", ["counter_cache"], name: "index_commentaries_on_counter_cache", using: :btree
  add_index "commentaries", ["created_at"], name: "index_commentaries_on_created_at", using: :btree

  create_table "commentaries_sources", id: false, force: true do |t|
    t.integer "commentary_id"
    t.integer "source_id"
  end

  add_index "commentaries_sources", ["commentary_id", "source_id"], name: "index_commentaries_sources_on_commentary_id_and_source_id", unique: true, using: :btree
  add_index "commentaries_sources", ["commentary_id"], name: "index_commentaries_sources_on_commentary_id", using: :btree
  add_index "commentaries_sources", ["source_id"], name: "index_commentaries_sources_on_source_id", using: :btree

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
    t.integer  "start_year"
    t.integer  "end_year"
  end

  add_index "eras", ["end_year"], name: "index_eras_on_end_year", using: :btree
  add_index "eras", ["name"], name: "index_eras_on_name", using: :btree
  add_index "eras", ["parent_id"], name: "index_eras_on_parent_id", using: :btree
  add_index "eras", ["start_year"], name: "index_eras_on_start_year", using: :btree

  create_table "eras_sources", id: false, force: true do |t|
    t.integer "era_id"
    t.integer "source_id"
  end

  add_index "eras_sources", ["era_id", "source_id"], name: "index_eras_sources_on_era_id_and_source_id", unique: true, using: :btree
  add_index "eras_sources", ["era_id"], name: "index_eras_sources_on_era_id", using: :btree
  add_index "eras_sources", ["source_id"], name: "index_eras_sources_on_source_id", using: :btree

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree

  create_table "pages", force: true do |t|
    t.string  "image"
    t.integer "source_id"
    t.integer "number"
  end

  add_index "pages", ["number"], name: "index_pages_on_number", using: :btree
  add_index "pages", ["source_id"], name: "index_pages_on_source_id", using: :btree

  create_table "reference_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reference_types", ["name"], name: "index_reference_types_on_name", using: :btree

  create_table "reference_types_sources", force: true do |t|
    t.integer "reference_type_id"
    t.integer "source_id"
  end

  add_index "reference_types_sources", ["reference_type_id"], name: "index_reference_types_sources_on_reference_type_id", using: :btree
  add_index "reference_types_sources", ["source_id", "reference_type_id"], name: "ref_type_sources_composite", unique: true, using: :btree
  add_index "reference_types_sources", ["source_id"], name: "index_reference_types_sources_on_source_id", using: :btree

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

  create_table "regions_sources", force: true do |t|
    t.integer "region_id"
    t.integer "source_id"
  end

  add_index "regions_sources", ["region_id", "source_id"], name: "index_regions_sources_on_region_id_and_source_id", unique: true, using: :btree
  add_index "regions_sources", ["region_id"], name: "index_regions_sources_on_region_id", using: :btree
  add_index "regions_sources", ["source_id"], name: "index_regions_sources_on_source_id", using: :btree

  create_table "source_sources", id: false, force: true do |t|
    t.integer "source_id"
    t.integer "referenced_id"
  end

  add_index "source_sources", ["referenced_id"], name: "index_source_sources_on_referenced_id", using: :btree
  add_index "source_sources", ["source_id", "referenced_id"], name: "index_source_sources_on_source_id_and_referenced_id", unique: true, using: :btree
  add_index "source_sources", ["source_id"], name: "index_source_sources_on_source_id", using: :btree

  create_table "sources", force: true do |t|
    t.string   "title"
    t.integer  "document_type_id"
    t.string   "pdf"
    t.boolean  "processed",          default: true
    t.date     "gregorian_date"
    t.date     "lunar_hijri_date"
    t.string   "source_name"
    t.string   "source_url"
    t.string   "author"
    t.string   "translators"
    t.string   "editors"
    t.string   "publisher"
    t.string   "publisher_location"
    t.integer  "volume_count"
    t.string   "alternate_titles"
    t.string   "alternate_authors"
    t.integer  "language_id"
    t.integer  "contributor_id"
    t.integer  "counter_cache",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sources", ["contributor_id"], name: "index_sources_on_contributor_id", using: :btree
  add_index "sources", ["counter_cache"], name: "index_sources_on_counter_cache", using: :btree
  add_index "sources", ["created_at"], name: "index_sources_on_created_at", using: :btree
  add_index "sources", ["document_type_id"], name: "index_sources_on_document_type_id", using: :btree
  add_index "sources", ["language_id"], name: "index_sources_on_language_id", using: :btree

  create_table "sources_tags", id: false, force: true do |t|
    t.integer "source_id"
    t.integer "tag_id"
  end

  add_index "sources_tags", ["source_id", "tag_id"], name: "index_sources_tags_on_source_id_and_tag_id", unique: true, using: :btree
  add_index "sources_tags", ["source_id"], name: "index_sources_tags_on_source_id", using: :btree
  add_index "sources_tags", ["tag_id"], name: "index_sources_tags_on_tag_id", using: :btree

  create_table "sources_themes", force: true do |t|
    t.integer "source_id"
    t.integer "theme_id"
  end

  add_index "sources_themes", ["source_id", "theme_id"], name: "index_sources_themes_on_source_id_and_theme_id", unique: true, using: :btree
  add_index "sources_themes", ["source_id"], name: "index_sources_themes_on_source_id", using: :btree
  add_index "sources_themes", ["theme_id"], name: "index_sources_themes_on_theme_id", using: :btree

  create_table "sources_topics", id: false, force: true do |t|
    t.integer "source_id"
    t.integer "topic_id"
  end

  add_index "sources_topics", ["source_id", "topic_id"], name: "index_sources_topics_on_source_id_and_topic_id", unique: true, using: :btree
  add_index "sources_topics", ["source_id"], name: "index_sources_topics_on_source_id", using: :btree
  add_index "sources_topics", ["topic_id"], name: "index_sources_topics_on_topic_id", using: :btree

  create_table "statics", force: true do |t|
    t.string   "slug"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "statics", ["slug"], name: "index_statics_on_slug", using: :btree

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

  create_table "user_hierarchies", id: false, force: true do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "user_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "user_anc_des_udx", unique: true, using: :btree
  add_index "user_hierarchies", ["descendant_id"], name: "user_desc_idx", using: :btree

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
    t.integer  "parent_id"
    t.text     "about"
    t.string   "avatar"
  end

  add_index "users", ["collaborator_id"], name: "index_users_on_collaborator_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_admin"], name: "index_users_on_is_admin", using: :btree
  add_index "users", ["is_contributor"], name: "index_users_on_is_contributor", using: :btree
  add_index "users", ["is_editor"], name: "index_users_on_is_editor", using: :btree
  add_index "users", ["last_name_without_articles"], name: "index_users_on_last_name_without_articles", using: :btree
  add_index "users", ["parent_id"], name: "index_users_on_parent_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
