class AddOriginalAuthorToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_reference :documents, :original_author, foreign_key: { to_table: :users}
  end
end
