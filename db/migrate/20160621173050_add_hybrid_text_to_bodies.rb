class AddHybridTextToBodies < ActiveRecord::Migration[5.1]
  def change
    add_column :bodies, :hybrid_text, :text
  end
end
