class AddStringMetadatasToSources < ActiveRecord::Migration
  def change
    change_table :sources do |t|
      t.column :gregorian_date, :date
      t.column :lunar_hijri_date, :date
      t.column :source_name, :string
      t.column :source_url, :string
      t.column :author, :string
      t.column :translators, :string
      t.column :editors, :string
      t.column :publisher, :string
      t.column :publisher_location, :string
      t.column :volume_count, :integer
      t.column :alternate_titles, :string
      t.column :alternate_authors, :string
    end
  end
end
