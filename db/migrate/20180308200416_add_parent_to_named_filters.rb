class AddParentToNamedFilters < ActiveRecord::Migration[5.1]
  def change
    add_reference :named_filters, :parent, foreign_key: { to_table: :named_filters }
  end
end
