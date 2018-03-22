class AddOcrDocumentIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :ocr_document_id, :string
  end
end
