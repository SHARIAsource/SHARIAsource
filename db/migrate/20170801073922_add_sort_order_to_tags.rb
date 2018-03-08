class AddSortOrderToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :sort_order, :integer
    add_index :tags, :sort_order
  end
end
