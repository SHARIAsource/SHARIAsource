class ChangeStaticsToMiscs < ActiveRecord::Migration[5.1]
  def change
    rename_table :statics, :miscs
  end
end
