class AddCnCMetadataJsonToAuthor < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :cnc_metadata_jsonb, :jsonb
  end
end
