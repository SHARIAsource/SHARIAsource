class AddWidthHeightToPage < ActiveRecord::Migration
  def change
    add_column :pages, :width, :integer
    add_column :pages, :height, :integer
  end
end
