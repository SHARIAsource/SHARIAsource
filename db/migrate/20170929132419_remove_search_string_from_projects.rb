class RemoveSearchStringFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :search_string
  end
end
