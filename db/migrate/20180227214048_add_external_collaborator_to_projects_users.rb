class AddExternalCollaboratorToProjectsUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :projects_users, :external_collaborator, :boolean
  end
end
