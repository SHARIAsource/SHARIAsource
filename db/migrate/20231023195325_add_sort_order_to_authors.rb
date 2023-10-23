class AddSortOrderToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :sort_order, :integer
  end
end
