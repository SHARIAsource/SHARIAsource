class ChangeSourcesProcessedDefault < ActiveRecord::Migration
  def up
    change_column_default :sources, :processed, true
  end

  def down
    change_column_default :sources, :processed, false
  end
end
