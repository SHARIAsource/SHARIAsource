class CreateJoinTableNamedFiltersDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :named_filter_documents do |t|
      t.integer :named_filter_id
      t.integer :document_id
    end
    add_index :named_filter_documents, :named_filter_id
    add_index :named_filter_documents, :document_id
    add_index :named_filter_documents, [:named_filter_id, :document_id], unique: true
  end
end
