class AddHybridTextToBodies < ActiveRecord::Migration
  def change
    add_column :bodies, :hybrid_text, :text
  end
end
