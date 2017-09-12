class CreateStatics < ActiveRecord::Migration[5.1]
  def change
    create_table :statics do |t|
      t.string :slug
      t.string :title
      t.timestamps
    end

    add_index :statics, :slug
  end
end
