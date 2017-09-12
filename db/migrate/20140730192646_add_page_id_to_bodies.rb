class AddPageIdToBodies < ActiveRecord::Migration[5.1]
  def change
    add_column :bodies, :page_id, :integer
    add_index :bodies, :page_id
  end
end
