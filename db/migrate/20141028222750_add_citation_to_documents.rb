class AddCitationToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :citation, :text
  end
end
