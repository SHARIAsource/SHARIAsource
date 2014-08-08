class MoveStaticTextIntoModel < ActiveRecord::Migration
  def change
    remove_index :bodies, :static_id
    remove_column :bodies, :static_id

    change_table :statics do |t|
      t.text :body
    end
  end
end
