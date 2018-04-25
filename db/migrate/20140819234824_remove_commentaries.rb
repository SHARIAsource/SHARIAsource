class RemoveCommentaries < ActiveRecord::Migration[5.1]
  def change
    drop_table :commentaries_sources
    drop_table :commentaries
  end
end
