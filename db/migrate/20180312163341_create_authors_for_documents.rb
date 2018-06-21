class CreateAuthorsForDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
    end

    create_join_table :documents, :authors do |t|
      t.index :document_id
      t.index :author_id
    end
  end
end
