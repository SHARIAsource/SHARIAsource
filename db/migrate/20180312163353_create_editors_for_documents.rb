class CreateEditorsForDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :editors do |t|
      t.string :name
    end

    create_join_table :documents, :editors do |t|
      t.index :document_id
      t.index :editor_id
    end
  end
end
