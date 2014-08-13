class CreateCommentariesSources < ActiveRecord::Migration
  def change
    create_table :commentaries_sources, id: false do |t|
      t.integer :commentary_id
      t.integer :source_id
    end

    add_index :commentaries_sources, :commentary_id
    add_index :commentaries_sources, :source_id
    add_index :commentaries_sources, [:commentary_id, :source_id], unique: true
  end
end
