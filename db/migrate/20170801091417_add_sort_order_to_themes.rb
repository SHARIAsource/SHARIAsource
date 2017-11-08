class AddSortOrderToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :sort_order, :integer
    add_index :themes, :sort_order
  end
end
