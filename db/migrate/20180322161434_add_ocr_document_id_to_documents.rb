class AddOcrDocumentIdToDocuments < ActiveRecord::Migration[4.2]
  def change
    add_column :documents, :ocr_document_id, :string
  end
end
