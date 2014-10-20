class AddArchivedToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :archived, :boolean, default: false
    add_index :themes, :archived
  end
end
