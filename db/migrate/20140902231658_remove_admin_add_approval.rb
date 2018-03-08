class RemoveAdminAddApproval < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, column: :is_admin
    remove_column :users, :is_admin, :boolean
    remove_index :users, column: :is_contributor
    remove_column :users, :is_contributor, :boolean
    add_column :users, :requires_approval, :boolean, default: false
    add_index :users, :requires_approval
  end
end
