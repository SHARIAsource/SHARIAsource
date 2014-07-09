class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :url
      t.text :description
      t.timestamps
    end

    add_index :collaborators, :name
  end
end
