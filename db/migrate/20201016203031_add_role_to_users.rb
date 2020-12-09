class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role_id, :integer
    add_index :users, :role_id
  end
end
