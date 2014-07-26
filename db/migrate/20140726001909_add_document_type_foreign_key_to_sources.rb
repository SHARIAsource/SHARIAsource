class AddDocumentTypeForeignKeyToSources < ActiveRecord::Migration
  def change
    add_column :sources, :document_type_id, :integer
    add_index :sources, :document_type_id
  end
end
