class CreateSourcesTags < ActiveRecord::Migration[5.1]
  def change
    create_table :sources_tags, id: false do |t|
      t.integer :source_id
      t.integer :tag_id
    end

    add_index :sources_tags, :source_id
    add_index :sources_tags, :tag_id
    add_index :sources_tags, [:source_id, :tag_id], unique: true
  end
end
