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

ActiveRecord::Schema.define(version: 20180810131110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attached_files", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.string "token"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attached_files_on_attachable_type_and_attachable_id"
    t.index ["user_id"], name: "index_attached_files_on_user_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "authors_documents", id: false, force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_authors_documents_on_author_id"
    t.index ["document_id"], name: "index_authors_documents_on_document_id"
  end

  create_table "bodies", id: :serial, force: :cascade do |t|
    t.text "text"
    t.integer "page_id"
    t.integer "commentary_id"
    t.integer "document_id"
    t.text "hybrid_text"
    t.index ["commentary_id"], name: "index_bodies_on_commentary_id", unique: true
    t.index ["document_id"], name: "index_bodies_on_document_id"
    t.index ["page_id"], name: "index_bodies_on_page_id"
  end

  create_table "collaborators", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "url", limit: 255
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image", limit: 255
    t.integer "sort_order"
    t.index ["name"], name: "index_collaborators_on_name"
    t.index ["sort_order"], name: "index_collaborators_on_sort_order"
  end

  create_table "contributors_documents", id: false, force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "contributor_id", null: false
    t.index ["contributor_id"], name: "index_contributors_documents_on_contributor_id"
    t.index ["document_id"], name: "index_contributors_documents_on_document_id"
  end

  create_table "document_documents", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "referenced_id"
    t.index ["document_id", "referenced_id"], name: "index_document_documents_on_document_id_and_referenced_id", unique: true
    t.index ["document_id"], name: "index_document_documents_on_document_id"
    t.index ["referenced_id"], name: "index_document_documents_on_referenced_id"
  end

  create_table "document_reviews", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_reviews_on_document_id"
    t.index ["user_id"], name: "index_document_reviews_on_user_id"
  end

  create_table "document_type_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "document_type_anc_des_udx", unique: true
    t.index ["descendant_id"], name: "document_type_desc_idx"
  end

  create_table "document_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
    t.integer "sort_order"
    t.index ["name"], name: "index_document_types_on_name"
    t.index ["parent_id"], name: "index_document_types_on_parent_id"
    t.index ["sort_order"], name: "index_document_types_on_sort_order"
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.integer "document_type_id"
    t.string "pdf", limit: 255
    t.string "source_name", limit: 255
    t.string "source_url", limit: 255
    t.string "publisher", limit: 255
    t.string "publisher_location", limit: 255
    t.integer "volume_count"
    t.string "alternate_titles", limit: 255
    t.string "alternate_authors", limit: 255
    t.integer "language_id"
    t.integer "popular_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "featured_position"
    t.integer "reference_type_id"
    t.string "permission_giver", limit: 255
    t.boolean "published", default: false
    t.string "document_style", limit: 255, default: "scan"
    t.string "alternate_editors", limit: 255
    t.string "alternate_translators", limit: 255
    t.string "alternate_years", limit: 255
    t.text "summary"
    t.datetime "published_at"
    t.text "citation"
    t.integer "gregorian_year"
    t.integer "gregorian_month"
    t.integer "gregorian_day"
    t.string "content_password"
    t.boolean "use_content_password", default: false
    t.boolean "reviewed", default: false
    t.bigint "user_id"
    t.index ["created_at"], name: "index_documents_on_created_at"
    t.index ["document_type_id"], name: "index_documents_on_document_type_id"
    t.index ["featured_position"], name: "index_documents_on_featured_position"
    t.index ["language_id"], name: "index_documents_on_language_id"
    t.index ["popular_count"], name: "index_documents_on_popular_count"
    t.index ["published"], name: "index_documents_on_published"
    t.index ["published_at"], name: "index_documents_on_published_at"
    t.index ["reference_type_id"], name: "index_documents_on_reference_type_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "documents_editors", id: false, force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "editor_id", null: false
    t.index ["document_id"], name: "index_documents_editors_on_document_id"
    t.index ["editor_id"], name: "index_documents_editors_on_editor_id"
  end

  create_table "documents_eras", id: false, force: :cascade do |t|
    t.integer "era_id"
    t.integer "document_id"
    t.index ["document_id"], name: "index_documents_eras_on_document_id"
    t.index ["era_id", "document_id"], name: "index_documents_eras_on_era_id_and_document_id", unique: true
    t.index ["era_id"], name: "index_documents_eras_on_era_id"
  end

  create_table "documents_regions", id: :serial, force: :cascade do |t|
    t.integer "region_id"
    t.integer "document_id"
    t.index ["document_id"], name: "index_documents_regions_on_document_id"
    t.index ["region_id", "document_id"], name: "index_documents_regions_on_region_id_and_document_id", unique: true
    t.index ["region_id"], name: "index_documents_regions_on_region_id"
  end

  create_table "documents_tags", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "tag_id"
    t.index ["document_id", "tag_id"], name: "index_documents_tags_on_document_id_and_tag_id", unique: true
    t.index ["document_id"], name: "index_documents_tags_on_document_id"
    t.index ["tag_id"], name: "index_documents_tags_on_tag_id"
  end

  create_table "documents_themes", id: :serial, force: :cascade do |t|
    t.integer "document_id"
    t.integer "theme_id"
    t.index ["document_id", "theme_id"], name: "index_documents_themes_on_document_id_and_theme_id", unique: true
    t.index ["document_id"], name: "index_documents_themes_on_document_id"
    t.index ["theme_id"], name: "index_documents_themes_on_theme_id"
  end

  create_table "documents_topics", id: false, force: :cascade do |t|
    t.integer "document_id"
    t.integer "topic_id"
    t.index ["document_id", "topic_id"], name: "index_documents_topics_on_document_id_and_topic_id", unique: true
    t.index ["document_id"], name: "index_documents_topics_on_document_id"
    t.index ["topic_id"], name: "index_documents_topics_on_topic_id"
  end

  create_table "documents_translators", id: false, force: :cascade do |t|
    t.bigint "document_id", null: false
    t.bigint "translator_id", null: false
    t.index ["document_id"], name: "index_documents_translators_on_document_id"
    t.index ["translator_id"], name: "index_documents_translators_on_translator_id"
  end

  create_table "editors", force: :cascade do |t|
    t.string "name"
  end

  create_table "era_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "era_anc_des_udx", unique: true
    t.index ["descendant_id"], name: "era_desc_idx"
  end

  create_table "eras", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "start_year_gregorian"
    t.integer "end_year_gregorian"
    t.integer "start_year_hijri"
    t.integer "end_year_hijri"
    t.boolean "extended", default: false
    t.string "hijri_display", limit: 255
    t.string "gregorian_display", limit: 255
    t.integer "sort_order"
    t.index ["end_year_gregorian"], name: "index_eras_on_end_year_gregorian"
    t.index ["extended"], name: "index_eras_on_extended"
    t.index ["name"], name: "index_eras_on_name"
    t.index ["parent_id"], name: "index_eras_on_parent_id"
    t.index ["sort_order"], name: "index_eras_on_sort_order"
    t.index ["start_year_gregorian"], name: "index_eras_on_start_year_gregorian"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "languages", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_rtl"
    t.integer "sort_order"
    t.index ["name"], name: "index_languages_on_name", unique: true
    t.index ["sort_order"], name: "index_languages_on_sort_order"
  end

  create_table "miscs", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255
    t.string "title", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "body"
    t.index ["slug"], name: "index_miscs_on_slug"
  end

  create_table "named_filter_additional_documents", force: :cascade do |t|
    t.integer "named_filter_id"
    t.integer "document_id"
    t.index ["document_id"], name: "n_f_add_doc_doc_id"
    t.index ["named_filter_id", "document_id"], name: "n_f_add_doc_nam_fil_doc_id", unique: true
    t.index ["named_filter_id"], name: "n_f_add_doc_nam_fil"
  end

  create_table "named_filter_documents", force: :cascade do |t|
    t.integer "named_filter_id"
    t.integer "document_id"
    t.index ["document_id"], name: "index_named_filter_documents_on_document_id"
    t.index ["named_filter_id", "document_id"], name: "index_named_filter_documents_on_named_filter_id_and_document_id", unique: true
    t.index ["named_filter_id"], name: "index_named_filter_documents_on_named_filter_id"
  end

  create_table "named_filter_excluded_documents", force: :cascade do |t|
    t.integer "named_filter_id"
    t.integer "document_id"
    t.index ["document_id"], name: "n_f_ex_doc_doc_id"
    t.index ["named_filter_id", "document_id"], name: "n_f_ex_doc_nam_fil_doc_id", unique: true
    t.index ["named_filter_id"], name: "n_f_ex_doc_nam_fil"
  end

  create_table "named_filters", force: :cascade do |t|
    t.string "name"
    t.string "q"
    t.date "date_from"
    t.date "date_to"
    t.string "date_format"
    t.bigint "language_id"
    t.bigint "user_id"
    t.bigint "topic_id"
    t.bigint "theme_id"
    t.bigint "region_id"
    t.bigint "era_id"
    t.bigint "document_type_id"
    t.bigint "project_id"
    t.string "sort"
    t.integer "page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_id"
    t.integer "priority", default: 1
    t.boolean "invert_region_id", default: false
    t.boolean "invert_language_id", default: false
    t.boolean "invert_document_type_id", default: false
    t.boolean "invert_theme_id", default: false
    t.boolean "invert_topic_id", default: false
    t.boolean "invert_era_id", default: false
    t.index ["document_type_id"], name: "index_named_filters_on_document_type_id"
    t.index ["era_id"], name: "index_named_filters_on_era_id"
    t.index ["language_id"], name: "index_named_filters_on_language_id"
    t.index ["parent_id"], name: "index_named_filters_on_parent_id"
    t.index ["project_id"], name: "index_named_filters_on_project_id"
    t.index ["region_id"], name: "index_named_filters_on_region_id"
    t.index ["theme_id"], name: "index_named_filters_on_theme_id"
    t.index ["topic_id"], name: "index_named_filters_on_topic_id"
    t.index ["user_id"], name: "index_named_filters_on_user_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "image", limit: 255
    t.integer "document_id"
    t.integer "number"
    t.integer "width"
    t.integer "height"
    t.index ["document_id"], name: "index_pages_on_document_id"
    t.index ["number"], name: "index_pages_on_number"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.boolean "scale_photo"
    t.boolean "published"
    t.string "slug"
    t.index ["slug"], name: "index_projects_on_slug", unique: true
  end

  create_table "projects_users", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.integer "sort_order", default: 1
    t.string "project_role"
    t.boolean "external_collaborator"
    t.index ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id"
    t.index ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id"
  end

  create_table "reference_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
    t.index ["name"], name: "index_reference_types_on_name"
    t.index ["sort_order"], name: "index_reference_types_on_sort_order"
  end

  create_table "region_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "region_anc_des_udx", unique: true
    t.index ["descendant_id"], name: "region_desc_idx"
  end

  create_table "regions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["name"], name: "index_regions_on_name"
    t.index ["parent_id"], name: "index_regions_on_parent_id"
    t.index ["sort_order"], name: "index_regions_on_sort_order"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
    t.index ["name"], name: "index_tags_on_name"
    t.index ["sort_order"], name: "index_tags_on_sort_order"
  end

  create_table "themes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "archived", default: false
    t.integer "sort_order"
    t.index ["archived"], name: "index_themes_on_archived"
    t.index ["name"], name: "index_themes_on_name"
    t.index ["sort_order"], name: "index_themes_on_sort_order"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sort_order"
    t.index ["name"], name: "index_topics_on_name"
    t.index ["sort_order"], name: "index_topics_on_sort_order"
  end

  create_table "translators", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "user_anc_des_udx", unique: true
    t.index ["descendant_id"], name: "user_desc_idx"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_editor", default: false
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "last_name_without_articles", limit: 255
    t.integer "collaborator_id"
    t.integer "parent_id"
    t.text "about"
    t.string "avatar", limit: 255
    t.boolean "requires_approval", default: false
    t.boolean "disabled"
    t.boolean "is_admin"
    t.boolean "accepted_terms", default: false
    t.boolean "is_senior_scholar", default: false
    t.boolean "is_original_author", default: false
    t.boolean "is_password_protector", default: false
    t.text "publications"
    t.text "other_links"
    t.index ["collaborator_id"], name: "index_users_on_collaborator_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["is_editor"], name: "index_users_on_is_editor"
    t.index ["last_name_without_articles"], name: "index_users_on_last_name_without_articles"
    t.index ["parent_id"], name: "index_users_on_parent_id"
    t.index ["requires_approval"], name: "index_users_on_requires_approval"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attached_files", "users"
  add_foreign_key "named_filters", "document_types"
  add_foreign_key "named_filters", "eras"
  add_foreign_key "named_filters", "languages"
  add_foreign_key "named_filters", "named_filters", column: "parent_id"
  add_foreign_key "named_filters", "projects"
  add_foreign_key "named_filters", "regions"
  add_foreign_key "named_filters", "themes"
  add_foreign_key "named_filters", "topics"
  add_foreign_key "named_filters", "users"
end
