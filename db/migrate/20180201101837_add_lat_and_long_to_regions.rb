class AddLatAndLongToRegions < ActiveRecord::Migration[5.1]
  def change
    add_column :regions, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :regions, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
