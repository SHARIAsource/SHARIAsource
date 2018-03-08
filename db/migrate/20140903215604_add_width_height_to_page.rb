class AddWidthHeightToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :width, :integer
    add_column :pages, :height, :integer
  end
end
