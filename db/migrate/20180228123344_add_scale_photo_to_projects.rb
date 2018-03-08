class AddScalePhotoToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :scale_photo, :boolean
  end
end
