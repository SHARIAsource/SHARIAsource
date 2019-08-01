class AddNewSubmissionEmailToAdminUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :new_submission_email, :boolean, default: true
  end
end
