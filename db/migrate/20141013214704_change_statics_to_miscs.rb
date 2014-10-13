class ChangeStaticsToMiscs < ActiveRecord::Migration
  def change
    rename_table :statics, :miscs
  end
end
