class RenameSources < ActiveRecord::Migration[5.1]
  def change
    rename_table :sources, :documents
    rename_table :eras_sources, :documents_eras
    rename_table :reference_types_sources, :documents_reference_types
    rename_table :regions_sources, :documents_regions
    rename_table :source_sources, :document_documents
    rename_table :sources_tags, :documents_tags
    rename_table :sources_themes, :documents_themes
    rename_table :sources_topics, :documents_topics

    rename_column :documents_eras, :source_id, :document_id
    rename_column :documents_reference_types, :source_id, :document_id
    rename_column :documents_regions, :source_id, :document_id
    rename_column :document_documents, :source_id, :document_id
    rename_column :documents_tags, :source_id, :document_id
    rename_column :documents_themes, :source_id, :document_id
    rename_column :documents_topics, :source_id, :document_id
    rename_column :bodies, :source_id, :document_id
    rename_column :pages, :source_id, :document_id
  end
end
