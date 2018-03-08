class CreateNamedFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :named_filters do |t|
      t.string :name
      t.string :q
      t.date :date_from
      t.date :date_to
      t.string :date_format
      t.references :language, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true
      t.references :theme, index: true, foreign_key: true
      t.references :region, index: true, foreign_key: true
      t.references :era, index: true, foreign_key: true
      t.references :document_type, index: true, foreign_key: true
      t.references :project, index: true, foreign_key: true
      t.string :sort
      t.integer :page

      t.timestamps null: false
    end
  end
end
