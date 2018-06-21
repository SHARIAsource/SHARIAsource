class CreateContributorsForDocuments < ActiveRecord::Migration[5.1]
  def change
    create_join_table :documents, :contributors do |t|
      t.index :document_id
      t.index :contributor_id
    end
  end
end
