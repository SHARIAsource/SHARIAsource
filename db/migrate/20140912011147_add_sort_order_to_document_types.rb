class AddSortOrderToDocumentTypes < ActiveRecord::Migration
  def change
    add_column :document_types, :sort_order, :integer
    add_index :document_types, :sort_order
  end
end
