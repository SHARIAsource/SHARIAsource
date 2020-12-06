class AddAttributionToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :attribution, :text
  end
end
