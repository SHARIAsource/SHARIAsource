class CreateThemes < ActiveRecord::Migration[5.1]
  def change
    create_table :themes do |t|
      t.string :name
      t.timestamps
    end

    add_index :themes, :name
  end
end
