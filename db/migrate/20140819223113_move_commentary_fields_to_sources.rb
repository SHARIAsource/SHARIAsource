class MoveCommentaryFieldsToSources < ActiveRecord::Migration
  def change
    add_column :sources, :featured_position, :integer
    add_column :bodies, :source_id, :integer

    add_index :sources, :featured_position
    add_index :bodies, :source_id
  end
end
