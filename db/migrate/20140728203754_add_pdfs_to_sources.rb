class AddPdfsToSources < ActiveRecord::Migration
  def change
    add_column :sources, :pdf, :string
  end
end
