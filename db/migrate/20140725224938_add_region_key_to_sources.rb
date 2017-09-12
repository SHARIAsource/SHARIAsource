class AddRegionKeyToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :region_id, :integer
    add_index :sources, :region_id
  end
end
