class AddPublicationsAndOtherLinksToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.text :publications
      t.text :other_links
    end
  end
end
