class AddSortOrderToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :sort_order, :integer
    add_index :topics, :sort_order
  end
end
