class SingularizeReferenceType < ActiveRecord::Migration
  def change
    drop_table :documents_reference_types
    add_column :documents, :reference_type_id, :integer
    add_index :documents, :reference_type_id
  end
end
