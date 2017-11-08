class AddSortOrderToTags < ActiveRecord::Migration
  def change
    add_column :tags, :sort_order, :integer
    add_index :tags, :sort_order
  end
end
