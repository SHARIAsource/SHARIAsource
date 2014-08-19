class RemoveCommentaries < ActiveRecord::Migration
  def change
    drop_table :commentaries_sources
    drop_table :commentaries
  end
end
