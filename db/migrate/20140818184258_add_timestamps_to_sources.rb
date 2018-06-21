class AddTimestampsToSources < ActiveRecord::Migration[5.1]
  def change
    change_table :sources do |t|
      t.timestamps
    end

    add_index :sources, :created_at
  end
end
