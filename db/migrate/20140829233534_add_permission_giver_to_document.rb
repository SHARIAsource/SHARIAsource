class AddPermissionGiverToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :permission_giver, :string
  end
end
