class AddSeniorScholarToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_senior_scholar, :boolean, default: false
  end
end
