class AddRolesToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_editor, :boolean, default: false
    add_column :users, :is_contributor, :boolean, default: false

    add_index :users, :is_admin
    add_index :users, :is_editor
    add_index :users, :is_contributor
  end
end
