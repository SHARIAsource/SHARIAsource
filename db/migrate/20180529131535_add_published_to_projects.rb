class AddPublishedToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :published, :boolean

    Project.update_all published: true
  end
end
