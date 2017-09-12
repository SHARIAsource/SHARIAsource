class ChangeBodiesForWysiwyg < ActiveRecord::Migration[5.1]
  def change
    change_table :bodies do |t|
      t.remove :rendered_text
      t.rename :source_text, :text
    end
  end
end
