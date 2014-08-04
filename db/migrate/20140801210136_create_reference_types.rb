class CreateReferenceTypes < ActiveRecord::Migration
  def change
    create_table :reference_types do |t|
      t.string :name
      t.timestamps
    end

    create_table :reference_types_sources do |t|
      t.integer :reference_type_id
      t.integer :source_id
    end

    add_index :reference_types, :name
    add_index :reference_types_sources, :source_id
    add_index :reference_types_sources, :reference_type_id
    add_index :reference_types_sources,
      [:source_id, :reference_type_id],
      unique: true,
      name: 'ref_type_sources_composite'
  end
end
