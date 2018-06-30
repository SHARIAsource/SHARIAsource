class AddUserIdToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :user_id, :integer
  end
end
