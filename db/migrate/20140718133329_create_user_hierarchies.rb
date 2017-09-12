class CreateUserHierarchies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :user_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'user_anc_des_udx'
    add_index :user_hierarchies, [:descendant_id], name: 'user_desc_idx'
  end
end
