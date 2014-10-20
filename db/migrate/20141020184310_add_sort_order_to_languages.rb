class AddSortOrderToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :sort_order, :integer
    add_index :languages, :sort_order
  end
end
