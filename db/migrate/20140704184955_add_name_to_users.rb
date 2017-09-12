class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :last_name_without_articles, :string

    add_index :users, :last_name_without_articles
  end
end
