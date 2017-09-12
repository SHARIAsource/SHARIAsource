class AddSeniorScholarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_senior_scholar, :boolean, default: false
  end
end
