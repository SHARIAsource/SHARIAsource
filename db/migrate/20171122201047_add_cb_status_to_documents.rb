class AddCbStatusToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :cb_status,  :string
  end
end
