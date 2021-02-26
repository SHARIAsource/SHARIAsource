class AddFeaturedPositionToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :featured_position, :integer
  end
end
