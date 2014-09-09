class AddExtendedToEras < ActiveRecord::Migration
  def change
    rename_column :eras, :start_year, :start_year_gregorian
    rename_column :eras, :end_year, :end_year_gregorian
    add_column :eras, :start_year_hijri, :integer
    add_column :eras, :end_year_hijri, :integer
    add_column :eras, :extended, :boolean, default: false
    add_column :eras, :hijri_display, :string
    add_column :eras, :gregorian_display, :string
    add_index :eras, :extended
  end
end
