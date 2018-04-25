class AddCitationToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :citation, :text
  end
end
