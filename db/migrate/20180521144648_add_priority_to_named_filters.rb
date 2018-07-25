class AddPriorityToNamedFilters < ActiveRecord::Migration[5.1]
  def change
    add_column :named_filters, :priority, :integer, default: 1
  end
end
