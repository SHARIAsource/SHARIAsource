class AddFeaturedLibraryPositionToCollaborators < ActiveRecord::Migration[6.1]
  def change
    add_column :collaborators, :featured_library_position, :integer
  end
end
