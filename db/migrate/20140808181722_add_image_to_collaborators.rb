class AddImageToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :image, :string
  end
end
