class AddCncMetadataIdToAuthor < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :cnc_metadata_id, :integer
  end
end
