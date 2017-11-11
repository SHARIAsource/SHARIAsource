class AddSortOrderToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :sort_order, :integer
  end
end
