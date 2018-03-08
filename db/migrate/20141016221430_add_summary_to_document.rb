class AddSummaryToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :summary, :text
  end
end
