class CreateSourcesThemes < ActiveRecord::Migration
  def change
    create_table :sources_themes do |t|
      t.integer :source_id
      t.integer :theme_id
    end

    add_index :sources_themes, :source_id
    add_index :sources_themes, :theme_id
    add_index :sources_themes, [:source_id, :theme_id], unique: true
  end
end
