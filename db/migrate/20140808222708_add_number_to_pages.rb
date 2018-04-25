class AddNumberToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :number, :integer
    add_index :pages, :number
  end
end
