class AddCommentaryFkToBodies < ActiveRecord::Migration[5.1]
  def change
    add_column :bodies, :commentary_id, :integer
    add_index :bodies, :commentary_id, unique: true
  end
end
