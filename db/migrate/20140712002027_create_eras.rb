class CreateEras < ActiveRecord::Migration
  def change
    create_table :eras do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps
    end

    add_index :eras, :parent_id
    add_index :eras, :name
  end
end
