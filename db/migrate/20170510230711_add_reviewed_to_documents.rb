class AddReviewedToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :reviewed, :boolean, default: false
  end
end
