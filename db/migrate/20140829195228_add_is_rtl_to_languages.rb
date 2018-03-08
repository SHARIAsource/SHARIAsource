class AddIsRtlToLanguages < ActiveRecord::Migration[5.1]
  def change
    add_column :languages, :is_rtl, :boolean
  end
end
