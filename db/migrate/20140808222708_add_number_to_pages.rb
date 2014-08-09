class AddNumberToPages < ActiveRecord::Migration
  def change
    add_column :pages, :number, :integer
    add_index :pages, :number
  end
end
