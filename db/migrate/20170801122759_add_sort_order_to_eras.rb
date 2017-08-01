class AddSortOrderToEras < ActiveRecord::Migration
  def up
    add_column :eras, :sort_order, :integer
    add_index :eras, :sort_order

    execute <<-sql
      update eras
      set sort_order = x.row_order
      from (
        select id, row_number()
        over (order by name asc) as row_order
        from eras
      ) x
      where eras.id = x.id
    sql
  end

  def down
    remove_index :eras, :sort_order
    remove_column :eras, :sort_order
  end
end
