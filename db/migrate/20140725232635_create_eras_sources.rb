class CreateErasSources < ActiveRecord::Migration
  def change
    create_table :eras_sources, id: false do |t|
      t.integer :era_id
      t.integer :source_id
    end

    add_index :eras_sources, :era_id
    add_index :eras_sources, :source_id
    add_index :eras_sources, [:era_id, :source_id], unique: true
  end
end
