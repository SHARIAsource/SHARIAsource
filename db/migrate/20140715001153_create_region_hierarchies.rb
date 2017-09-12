class CreateRegionHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :region_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :region_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'region_anc_des_udx'
    add_index :region_hierarchies, [:descendant_id], name: 'region_desc_idx'
  end
end
