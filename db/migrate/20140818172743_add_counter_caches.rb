class AddCounterCaches < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :popular_count, :integer, default: 0
    add_column :commentaries, :popular_count, :integer, default: 0

    add_index :sources, :popular_count
    add_index :commentaries, :popular_count
  end
end
