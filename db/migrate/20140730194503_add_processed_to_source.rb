class AddProcessedToSource < ActiveRecord::Migration
  def change
    add_column :sources, :processed, :boolean, default: false
  end
end
