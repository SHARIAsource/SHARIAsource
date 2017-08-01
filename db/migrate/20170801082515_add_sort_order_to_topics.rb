class AddSortOrderToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :sort_order, :integer
    add_index :topics, :sort_order
  end
end
