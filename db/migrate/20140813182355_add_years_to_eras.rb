class AddYearsToEras < ActiveRecord::Migration
  def change
    change_table :eras do |t|
      t.integer :start_year
      t.integer :end_year
    end

    add_index :eras, :start_year
    add_index :eras, :end_year
  end
end
