class AddPublicationsAndOtherLinksToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :publications
      t.text :other_links
    end
  end
end
