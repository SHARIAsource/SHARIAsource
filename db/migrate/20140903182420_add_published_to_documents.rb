class AddPublishedToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :published, :boolean, default: false
    add_index :documents, :published
  end
end
