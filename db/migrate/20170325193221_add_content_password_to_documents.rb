class AddContentPasswordToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :content_password, :string
    add_column :documents, :use_content_password, :boolean, default: false
  end
end
