class CreateAttachedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :attached_files do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :attachable, polymorphic: true, index: true
      t.string :token
      t.string :file

      t.timestamps null: false
    end
  end
end
