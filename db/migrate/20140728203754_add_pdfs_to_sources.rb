class AddPdfsToSources < ActiveRecord::Migration[5.1]
  def change
    add_column :sources, :pdf, :string
  end
end
