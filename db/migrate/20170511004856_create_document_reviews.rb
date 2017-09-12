class CreateDocumentReviews < ActiveRecord::Migration
  def change
    create_table :document_reviews do |t|
      t.references :document, required: true
      t.references :user, required: true

      t.timestamps
    end
  end
end
