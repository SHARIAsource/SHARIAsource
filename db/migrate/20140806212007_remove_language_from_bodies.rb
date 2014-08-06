class RemoveLanguageFromBodies < ActiveRecord::Migration
  def change
    remove_column :bodies, :language
  end
end
