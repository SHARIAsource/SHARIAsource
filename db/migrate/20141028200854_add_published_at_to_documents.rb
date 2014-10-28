class AddPublishedAtToDocuments < ActiveRecord::Migration
  def up
    add_column :documents, :published_at, :datetime
    add_index :documents, :published_at
    Document.all.each {|d| d.update_attribute :published_at, d.created_at }
  end

  def down
    remove_index :documents, :published_at
    remove_column :documents, :published_at
  end
end
