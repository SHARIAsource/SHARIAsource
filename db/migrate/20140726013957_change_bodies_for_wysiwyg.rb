class ChangeBodiesForWysiwyg < ActiveRecord::Migration
  def change
    change_table :bodies do |t|
      t.remove :rendered_text
      t.rename :source_text, :text
    end
  end
end
