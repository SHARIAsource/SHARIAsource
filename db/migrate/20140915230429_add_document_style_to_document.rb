class AddDocumentStyleToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :document_style, :string, default: 'scan'
  end
end
