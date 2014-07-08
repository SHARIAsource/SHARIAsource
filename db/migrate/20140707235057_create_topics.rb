class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
    end
  end
end
