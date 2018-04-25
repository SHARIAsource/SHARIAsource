class AddIsPasswordProtectorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_password_protector, :boolean, default: false
  end
end
