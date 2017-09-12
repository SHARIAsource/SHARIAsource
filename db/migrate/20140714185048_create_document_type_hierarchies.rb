class CreateDocumentTypeHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :document_type_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :document_type_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'document_type_anc_des_udx'
    add_index :document_type_hierarchies, [:descendant_id], name: 'document_type_desc_idx'
  end
end
