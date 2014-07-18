class AddParentToUser < ActiveRecord::Migration
  def change
    add_column :users, :parent_id, :integer
    add_index :users, :parent_id
  end
end
