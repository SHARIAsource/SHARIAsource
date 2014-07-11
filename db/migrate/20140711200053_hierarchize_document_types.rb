class HierarchizeDocumentTypes < ActiveRecord::Migration
  def change
    add_column :document_types, :parent_id, :integer
    add_index :document_types, :parent_id
  end
end
