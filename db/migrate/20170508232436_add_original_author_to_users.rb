class AddOriginalAuthorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_original_author, :boolean, default: false
  end
end
