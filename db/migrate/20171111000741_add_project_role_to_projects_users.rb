class AddProjectRoleToProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :project_role, :string
  end
end
