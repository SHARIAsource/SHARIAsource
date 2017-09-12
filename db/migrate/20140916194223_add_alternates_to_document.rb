class AddAlternatesToDocument < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :alternate_editors, :string
    add_column :documents, :alternate_translators, :string
    add_column :documents, :alternate_years, :string
  end
end
