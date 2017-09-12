class AddArchivedToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :archived, :boolean, default: false
    add_index :themes, :archived
  end
end
