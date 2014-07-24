class CreateBodies < ActiveRecord::Migration
  def change
    create_table :bodies do |t|
      t.text :source_text
      t.text :rendered_text
      t.integer :static_id
    end

    add_index :bodies, :static_id
  end
end
