class CreateTranslatorsForDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :translators do |t|
      t.string :name
    end

    create_join_table :documents, :translators do |t|
      t.index :document_id
      t.index :translator_id
    end
  end
end
