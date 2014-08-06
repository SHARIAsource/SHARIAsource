class CreateCommentaries < ActiveRecord::Migration
  def change
    create_table :commentaries do |t|
      t.string :title
      t.integer :contributor_id
      t.timestamps
    end

    add_index :commentaries, :created_at
  end
end
