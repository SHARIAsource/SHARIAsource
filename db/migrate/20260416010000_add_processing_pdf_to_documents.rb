class AddProcessingPdfToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :processing_pdf, :boolean, default: false, null: false
  end
end
