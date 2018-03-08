class AddUserToDocuments < ActiveRecord::Migration[5.1]
  def up
    add_reference :documents, :user, index: true

    # Backport contrib ID to user ID, which won't be 100% accurate, but
    #   it's the best we can do since we didn't track user_id from day one.
    Document.update_all("user_id = contributor_id")
  end

  def down
    remove_column :documents, :user_id
  end
end
