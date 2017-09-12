class AddSortOrderToLanguages < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :sort_order, :integer
    add_index :languages, :sort_order
  end
end
