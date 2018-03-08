class AddSortOrderToProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :sort_order, :integer, :default => 1
  end
end
