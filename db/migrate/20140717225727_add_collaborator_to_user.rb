class AddCollaboratorToUser < ActiveRecord::Migration
  def change
    add_column :users, :collaborator_id, :integer
    add_index :users, :collaborator_id
  end
end
