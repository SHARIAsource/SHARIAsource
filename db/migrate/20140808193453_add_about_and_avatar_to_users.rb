class AddAboutAndAvatarToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.text :about
      t.string :avatar
    end
  end
end
