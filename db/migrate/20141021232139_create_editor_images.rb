class CreateEditorImages < ActiveRecord::Migration
  def change
    create_table :editor_images do |t|
      t.string :image
      t.string :name
      t.timestamps
    end
    add_index :editor_images, :created_at
  end
end
