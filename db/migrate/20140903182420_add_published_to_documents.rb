class AddPublishedToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :published, :boolean, default: false
    add_index :documents, :published
  end
end
