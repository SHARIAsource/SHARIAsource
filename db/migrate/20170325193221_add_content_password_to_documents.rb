class AddContentPasswordToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :content_password, :string
    add_column :documents, :use_content_password, :boolean, default: false
  end
end
