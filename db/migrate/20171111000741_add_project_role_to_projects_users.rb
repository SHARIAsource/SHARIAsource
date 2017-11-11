class AddProjectRoleToProjectsUsers < ActiveRecord::Migration
  def change
    add_column :projects_users, :project_role, :string
  end
end
