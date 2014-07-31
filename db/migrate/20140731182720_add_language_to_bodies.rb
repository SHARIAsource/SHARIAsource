class AddLanguageToBodies < ActiveRecord::Migration
  def change
    add_column :bodies, :language, :string
  end
end
