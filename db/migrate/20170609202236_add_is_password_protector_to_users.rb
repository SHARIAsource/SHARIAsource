class AddIsPasswordProtectorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_password_protector, :boolean, default: false
  end
end
