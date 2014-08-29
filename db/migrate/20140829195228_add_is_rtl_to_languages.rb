class AddIsRtlToLanguages < ActiveRecord::Migration
  def change
    add_column :languages, :is_rtl, :boolean
  end
end
