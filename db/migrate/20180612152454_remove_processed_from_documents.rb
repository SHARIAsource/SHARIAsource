class RemoveProcessedFromDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :processed
  end
end
