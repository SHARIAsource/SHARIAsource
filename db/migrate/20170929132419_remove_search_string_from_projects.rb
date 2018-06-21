class RemoveSearchStringFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :search_string
  end
end
