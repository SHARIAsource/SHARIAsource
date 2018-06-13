class AddInvertersToNamedFilters < ActiveRecord::Migration[5.1]
  def change
    add_column :named_filters, :invert_region_id, :boolean, default: false
    add_column :named_filters, :invert_language_id, :boolean, default: false
    add_column :named_filters, :invert_document_type_id, :boolean, default: false
    add_column :named_filters, :invert_theme_id, :boolean, default: false
    add_column :named_filters, :invert_topic_id, :boolean, default: false
    add_column :named_filters, :invert_era_id, :boolean, default: false
  end
end
