class AddFeaturedToCommentaries < ActiveRecord::Migration[5.1]
  def change
    add_column :commentaries, :featured_position, :integer
    add_index :commentaries, :featured_position
  end
end
