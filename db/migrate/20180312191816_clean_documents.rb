class CleanDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :author
    remove_column :documents, :translators
    remove_column :documents, :editors
    remove_column :documents, :contributor_id
  end
end
