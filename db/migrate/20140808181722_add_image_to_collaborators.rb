class AddImageToCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_column :collaborators, :image, :string
  end
end
