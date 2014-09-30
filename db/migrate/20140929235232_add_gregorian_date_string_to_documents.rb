class AddGregorianDateStringToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :gregorian_date_string, :string
  end
end
