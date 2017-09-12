class AddCollaboratorToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :collaborator_id, :integer
    add_index :users, :collaborator_id
  end
end
