class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :image
      t.integer :source_id
    end

    add_index :pages, :source_id
  end
end
