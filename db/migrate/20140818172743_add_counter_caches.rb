class AddCounterCaches < ActiveRecord::Migration
  def change
    add_column :sources, :counter_cache, :integer, default: 0
    add_column :commentaries, :counter_cache, :integer, default: 0

    add_index :sources, :counter_cache
    add_index :commentaries, :counter_cache
  end
end
