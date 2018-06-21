class RemoveHijriDateFieldFromDocuments < ActiveRecord::Migration[5.1]
  def change
    remove_column :documents, :lunar_hijri_date, :date
  end
end
