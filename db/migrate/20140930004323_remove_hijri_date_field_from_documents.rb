class RemoveHijriDateFieldFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :lunar_hijri_date, :date
  end
end
