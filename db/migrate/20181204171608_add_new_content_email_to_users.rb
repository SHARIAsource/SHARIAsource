class AddNewContentEmailToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :new_content_email, :boolean, default: true
  end
end
