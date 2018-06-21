class AddIdToProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :id, :primary_key
  end
end
