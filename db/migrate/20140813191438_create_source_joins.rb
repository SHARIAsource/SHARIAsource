class CreateSourceJoins < ActiveRecord::Migration[5.1]
  def change
    create_table :source_sources, id: false do |t|
      t.integer :source_id
      t.integer :referenced_id
    end

    add_index :source_sources, :source_id
    add_index :source_sources, :referenced_id
    add_index :source_sources, [:source_id, :referenced_id], unique: true
  end
end
