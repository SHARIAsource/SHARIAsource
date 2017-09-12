class AddSortOrderToRegions < ActiveRecord::Migration
  def up
    add_column :regions, :sort_order, :integer
    add_index :regions, :sort_order

    execute <<-sql
      update regions
      set sort_order = x.row_order
      from (
        select id, row_number()
        over (order by name asc) as row_order
        from regions
      ) x
      where regions.id = x.id
    sql
  end

  def down
    remove_index :regions, :sort_order
    remove_column :regions, :sort_order
  end
end
