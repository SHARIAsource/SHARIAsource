class AddDocumentStyleToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :document_style, :string, default: 'scan'
  end
end
