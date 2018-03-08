class AddDisabledToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :disabled, :boolean
  end
end
