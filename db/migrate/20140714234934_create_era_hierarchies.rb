class CreateEraHierarchies < ActiveRecord::Migration
  def change
    create_table :era_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :era_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'era_anc_des_udx'
    add_index :era_hierarchies, [:descendant_id], name: 'era_desc_idx'
  end
end
