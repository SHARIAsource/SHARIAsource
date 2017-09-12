class AddAboutAndAvatarToUsers < ActiveRecord::Migration[5.1]
  def change
    change_table :users do |t|
      t.text :about
      t.string :avatar
    end
  end
end
