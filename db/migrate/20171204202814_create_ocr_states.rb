class CreateOcrStates < ActiveRecord::Migration
  def change
    create_table :ocr_states do |t|
      t.integer :state, nil: false
      t.integer :status, nil: false
      t.text :error_message
      t.references :document, index: true, foreign_key: true

      t.timestamps
    end
  end
end
