class AddWordDocumentToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :word_document, :string
  end
end
