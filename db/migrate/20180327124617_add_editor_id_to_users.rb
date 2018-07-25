class AddEditorIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :cb_editor_id, :string
  end
end
