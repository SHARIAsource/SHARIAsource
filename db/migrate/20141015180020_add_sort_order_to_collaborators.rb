class AddSortOrderToCollaborators < ActiveRecord::Migration[5.1]
  def up
    add_column :collaborators, :sort_order, :integer
    add_index :collaborators, :sort_order
    Collaborator.all.each_with_index do |c, i|
      c.sort_order = i
    end
  end

  def down
    remove_index :collaborators, :sort_order
    remove_column :collaborators, :sort_order
  end
end
