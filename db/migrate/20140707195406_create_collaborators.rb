class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :url
      t.text :description
    end
  end
end
