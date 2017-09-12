class AddReviewedToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :reviewed, :boolean, default: false
  end
end
