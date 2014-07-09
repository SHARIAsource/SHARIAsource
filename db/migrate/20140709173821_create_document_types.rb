class CreateDocumentTypes < ActiveRecord::Migration
  def change
    create_table :document_types do |t|
      t.string :name
      t.timestamps
    end

    add_index :document_types, :name
  end
end
