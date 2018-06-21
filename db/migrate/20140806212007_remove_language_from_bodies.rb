class RemoveLanguageFromBodies < ActiveRecord::Migration[5.1]
  def change
    remove_column :bodies, :language
  end
end
