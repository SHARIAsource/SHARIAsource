class ChangeSourceRegionsToMultiselect < ActiveRecord::Migration
  def change
    remove_index :sources, :region_id
    remove_column :sources, :region_id

    create_table :regions_sources do |t|
      t.integer :region_id
      t.integer :source_id
    end

    add_index :regions_sources, :region_id
    add_index :regions_sources, :source_id
    add_index :regions_sources, [:region_id, :source_id], unique: true
  end
end
