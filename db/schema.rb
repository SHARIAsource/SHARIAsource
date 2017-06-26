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

ActiveRecord::Schema.define(version: 20170611201448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attached_files", force: :cascade do |t|
    t.integer  "user_id",         null: false
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "token"
    t.string   "file"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "attached_files", ["attachable_type", "attachable_id"], name: "index_attached_files_on_attachable_type_and_attachable_id", using: :btree
  add_index "attached_files", ["user_id"], name: "index_attached_files_on_user_id", using: :btree

  create_table "bodies", force: :cascade do |t|
    t.text    "text"
    t.integer "page_id"
    t.integer "commentary_id"
    t.integer "document_id"
    t.text    "hybrid_text"
  end

  add_index "bodies", ["commentary_id"], name: "index_bodies_on_commentary_id", unique: true, using: :btree
  add_index "bodies", ["document_id"], name: "index_bodies_on_document_id", using: :btree
  add_index "bodies", ["page_id"], name: "index_bodies_on_page_id", using: :btree

  create_table "collaborators", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",       limit: 255
    t.integer  "sort_order"
  end

  add_index "collaborators", ["name"], name: "index_collaborators_on_name", using: :btree
  add_index "collaborators", ["sort_order"], name: "index_collaborators_on_sort_order", using: :btree

  create_table "document_documents", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "referenced_id"
  end

  add_index "document_documents", ["document_id", "referenced_id"], name: "index_document_documents_on_document_id_and_referenced_id", unique: true, using: :btree
  add_index "document_documents", ["document_id"], name: "index_document_documents_on_document_id", using: :btree
  add_index "document_documents", ["referenced_id"], name: "index_document_documents_on_referenced_id", using: :btree

  create_table "document_reviews", force: :cascade do |t|
    t.integer  "document_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_type_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "document_type_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "document_type_anc_des_udx", unique: true, using: :btree
  add_index "document_type_hierarchies", ["descendant_id"], name: "document_type_desc_idx", using: :btree

  create_table "document_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "sort_order"
  end

  add_index "document_types", ["name"], name: "index_document_types_on_name", using: :btree
  add_index "document_types", ["parent_id"], name: "index_document_types_on_parent_id", using: :btree
  add_index "document_types", ["sort_order"], name: "index_document_types_on_sort_order", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "title",                 limit: 255
    t.integer  "document_type_id"
    t.string   "pdf",                   limit: 255
    t.boolean  "processed",                         default: true
    t.string   "source_name",           limit: 255
    t.string   "source_url",            limit: 255
    t.string   "author",                limit: 255
    t.string   "translators",           limit: 255
    t.string   "editors",               limit: 255
    t.string   "publisher",             limit: 255
    t.string   "publisher_location",    limit: 255
    t.integer  "volume_count"
    t.string   "alternate_titles",      limit: 255
    t.string   "alternate_authors",     limit: 255
    t.integer  "language_id"
    t.integer  "contributor_id"
    t.integer  "popular_count",                     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured_position"
    t.integer  "reference_type_id"
    t.string   "permission_giver",      limit: 255
    t.boolean  "published",                         default: false
    t.string   "document_style",        limit: 255, default: "scan"
    t.string   "alternate_editors",     limit: 255
    t.string   "alternate_translators", limit: 255
    t.string   "alternate_years",       limit: 255
    t.text     "summary"
    t.datetime "published_at"
    t.text     "citation"
    t.integer  "gregorian_year"
    t.integer  "gregorian_month"
    t.integer  "gregorian_day"
    t.string   "content_password"
    t.boolean  "use_content_password",              default: false
    t.boolean  "reviewed",                          default: false
    t.integer  "user_id"
  end

  add_index "documents", ["contributor_id"], name: "index_documents_on_contributor_id", using: :btree
  add_index "documents", ["created_at"], name: "index_documents_on_created_at", using: :btree
  add_index "documents", ["document_type_id"], name: "index_documents_on_document_type_id", using: :btree
  add_index "documents", ["featured_position"], name: "index_documents_on_featured_position", using: :btree
  add_index "documents", ["language_id"], name: "index_documents_on_language_id", using: :btree
  add_index "documents", ["popular_count"], name: "index_documents_on_popular_count", using: :btree
  add_index "documents", ["published"], name: "index_documents_on_published", using: :btree
  add_index "documents", ["published_at"], name: "index_documents_on_published_at", using: :btree
  add_index "documents", ["reference_type_id"], name: "index_documents_on_reference_type_id", using: :btree
  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "documents_eras", id: false, force: :cascade do |t|
    t.integer "era_id"
    t.integer "document_id"
  end

  add_index "documents_eras", ["document_id"], name: "index_documents_eras_on_document_id", using: :btree
  add_index "documents_eras", ["era_id", "document_id"], name: "index_documents_eras_on_era_id_and_document_id", unique: true, using: :btree
  add_index "documents_eras", ["era_id"], name: "index_documents_eras_on_era_id", using: :btree

  create_table "documents_regions", force: :cascade do |t|
    t.integer "region_id"
    t.integer "document_id"
  end

  add_index "documents_regions", ["document_id"], name: "index_documents_regions_on_document_id", using: :btree
  add_index "documents_regions", ["region_id", "document_id"], name: "index_documents_regions_on_region_id_and_document_id", unique: true, using: :btree
  add_index "documents_regions", ["region_id"], name: "index_documents_regions_on_region_id", using: :btree

  create_table "documents_tags", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "tag_id"
  end

  add_index "documents_tags", ["document_id", "tag_id"], name: "index_documents_tags_on_document_id_and_tag_id", unique: true, using: :btree
  add_index "documents_tags", ["document_id"], name: "index_documents_tags_on_document_id", using: :btree
  add_index "documents_tags", ["tag_id"], name: "index_documents_tags_on_tag_id", using: :btree

  create_table "documents_themes", force: :cascade do |t|
    t.integer "document_id"
    t.integer "theme_id"
  end

  add_index "documents_themes", ["document_id", "theme_id"], name: "index_documents_themes_on_document_id_and_theme_id", unique: true, using: :btree
  add_index "documents_themes", ["document_id"], name: "index_documents_themes_on_document_id", using: :btree
  add_index "documents_themes", ["theme_id"], name: "index_documents_themes_on_theme_id", using: :btree

  create_table "documents_topics", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "topic_id"
  end

  add_index "documents_topics", ["document_id", "topic_id"], name: "index_documents_topics_on_document_id_and_topic_id", unique: true, using: :btree
  add_index "documents_topics", ["document_id"], name: "index_documents_topics_on_document_id", using: :btree
  add_index "documents_topics", ["topic_id"], name: "index_documents_topics_on_topic_id", using: :btree

  create_table "era_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "era_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "era_anc_des_udx", unique: true, using: :btree
  add_index "era_hierarchies", ["descendant_id"], name: "era_desc_idx", using: :btree

  create_table "eras", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_year_gregorian"
    t.integer  "end_year_gregorian"
    t.integer  "start_year_hijri"
    t.integer  "end_year_hijri"
    t.boolean  "extended",                         default: false
    t.string   "hijri_display",        limit: 255
    t.string   "gregorian_display",    limit: 255
  end

  add_index "eras", ["end_year_gregorian"], name: "index_eras_on_end_year_gregorian", using: :btree
  add_index "eras", ["extended"], name: "index_eras_on_extended", using: :btree
  add_index "eras", ["name"], name: "index_eras_on_name", using: :btree
  add_index "eras", ["parent_id"], name: "index_eras_on_parent_id", using: :btree
  add_index "eras", ["start_year_gregorian"], name: "index_eras_on_start_year_gregorian", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_rtl"
    t.integer  "sort_order"
  end

  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree
  add_index "languages", ["sort_order"], name: "index_languages_on_sort_order", using: :btree

  create_table "miscs", force: :cascade do |t|
    t.string   "slug",       limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "miscs", ["slug"], name: "index_miscs_on_slug", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string  "image",       limit: 255
    t.integer "document_id"
    t.integer "number"
    t.integer "width"
    t.integer "height"
  end

  add_index "pages", ["document_id"], name: "index_pages_on_document_id", using: :btree
  add_index "pages", ["number"], name: "index_pages_on_number", using: :btree

  create_table "reference_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reference_types", ["name"], name: "index_reference_types_on_name", using: :btree

  create_table "region_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "region_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "region_anc_des_udx", unique: true, using: :btree
  add_index "region_hierarchies", ["descendant_id"], name: "region_desc_idx", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["name"], name: "index_regions_on_name", using: :btree
  add_index "regions", ["parent_id"], name: "index_regions_on_parent_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",               default: false
  end

  add_index "themes", ["archived"], name: "index_themes_on_archived", using: :btree
  add_index "themes", ["name"], name: "index_themes_on_name", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["name"], name: "index_topics_on_name", using: :btree

  create_table "user_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "user_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "user_anc_des_udx", unique: true, using: :btree
  add_index "user_hierarchies", ["descendant_id"], name: "user_desc_idx", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                      limit: 255, default: "",    null: false
    t.string   "encrypted_password",         limit: 255, default: "",    null: false
    t.string   "reset_password_token",       limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",         limit: 255
    t.string   "last_sign_in_ip",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_editor",                              default: false
    t.string   "first_name",                 limit: 255
    t.string   "last_name",                  limit: 255
    t.string   "last_name_without_articles", limit: 255
    t.integer  "collaborator_id"
    t.integer  "parent_id"
    t.text     "about"
    t.string   "avatar",                     limit: 255
    t.boolean  "requires_approval",                      default: false
    t.boolean  "disabled"
    t.boolean  "is_admin"
    t.boolean  "accepted_terms",                         default: false
    t.boolean  "is_senior_scholar",                      default: false
    t.boolean  "is_original_author",                     default: false
    t.boolean  "is_password_protector",                  default: false
  end

  add_index "users", ["collaborator_id"], name: "index_users_on_collaborator_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["is_editor"], name: "index_users_on_is_editor", using: :btree
  add_index "users", ["last_name_without_articles"], name: "index_users_on_last_name_without_articles", using: :btree
  add_index "users", ["parent_id"], name: "index_users_on_parent_id", using: :btree
  add_index "users", ["requires_approval"], name: "index_users_on_requires_approval", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "attached_files", "users"
end
