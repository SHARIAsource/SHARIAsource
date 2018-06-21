class AddSortOrderToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :sort_order, :integer
    add_index :themes, :sort_order
  end
end
