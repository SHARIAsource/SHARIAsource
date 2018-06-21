class ChangeDocumentDateFields < ActiveRecord::Migration[5.1]
  def up
    add_column :documents, :gregorian_year, :integer
    add_column :documents, :gregorian_month, :integer
    add_column :documents, :gregorian_day, :integer
    Document.all.each do |d|
      d.gregorian_year = d.gregorian_date.year
      d.gregorian_month = d.gregorian_date.month
      d.gregorian_day = d.gregorian_date.day
      d.save
    end
    remove_column :documents, :gregorian_date
    remove_column :documents, :gregorian_date_string
  end

  def down
    add_column :documents, :gregorian_date, :date
    add_column :documents, :gregorian_date_string, :string
    Document.all.each do |d|
      d.gregorian_date = DateTime.new(d.gregorian_year, d.gregorian_month,
                                      d.gregorian_day)
      d.gregorian_date_string = "#{d.gregorian_year}-#{d.gregorian_month}-#{d.gregorian_day}"
      d.save
    end
    remove_column :documents, :gregorian_year
    remove_column :documents, :gregorian_month
    remove_column :documents, :gregorian_day
  end
end
