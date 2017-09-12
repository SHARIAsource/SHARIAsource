class AddLanguageToBodies < ActiveRecord::Migration[5.1]
  def change
    add_column :bodies, :language, :string
  end
end
