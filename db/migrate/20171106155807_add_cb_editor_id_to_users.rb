class AddCbEditorIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cb_editor_id, :string
  end
end
