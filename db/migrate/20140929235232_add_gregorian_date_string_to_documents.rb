class AddGregorianDateStringToDocuments < ActiveRecord::Migration[5.1]
  def change
    add_column :documents, :gregorian_date_string, :string
  end
end
