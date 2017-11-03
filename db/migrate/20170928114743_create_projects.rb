class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, nil: false
      t.text :description
      t.string :search_string

      t.timestamps null: false
    end
  end
end
