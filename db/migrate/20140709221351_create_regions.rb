class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps
    end

    add_index :regions, :parent_id
    add_index :regions, :name
  end
end
