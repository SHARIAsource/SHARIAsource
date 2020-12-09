class AddTermsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :term_start_year, :integer
    add_column :users, :term_end_year, :integer
  end
end
