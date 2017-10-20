class AddPhotoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :photo, :string
  end
end
