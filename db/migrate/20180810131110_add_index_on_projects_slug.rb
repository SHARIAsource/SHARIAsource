class AddIndexOnProjectsSlug < ActiveRecord::Migration[5.1]
  def change
    add_index :projects, :slug, unique: true
  end
end
