class AddCbDocumentIdToOcrStates < ActiveRecord::Migration
  def change
    add_column :ocr_states, :cb_document_id, :string
  end
end
