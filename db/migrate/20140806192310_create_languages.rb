class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.timestamps
    end

    change_table :sources do |t|
      t.integer :language_id
    end

    add_index :languages, :name, unique: true
    add_index :sources, :language_id
  end
end
