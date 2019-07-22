class AddIsOcrAdvancedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :is_ocr_advanced, :boolean, default: false
  end
end
