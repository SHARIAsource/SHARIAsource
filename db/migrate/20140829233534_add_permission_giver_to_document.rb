class AddPermissionGiverToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :permission_giver, :string
  end
end
