class AddRegionKeyToSources < ActiveRecord::Migration
  def change
    add_column :sources, :region_id, :integer
    add_index :sources, :region_id
  end
end
