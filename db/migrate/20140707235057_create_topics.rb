class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.timestamps
    end

    add_index :topics, :name
  end
end
