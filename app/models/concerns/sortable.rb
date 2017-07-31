module Sortable
  extend ActiveSupport::Concern

  included do
    def self.sort_by_dates
      update_sort('created_at')
    end

    def self.sort_by_names
      update_sort('name')
    end

    def self.update_sort(column_name)
      for direction in [ 'asc', 'desc' ]
        result = connection.execute <<-sql
          update #{table_name}
          set sort_order = x.row_order
          from (
            select id, row_number()
            over (order by #{column_name} #{direction}) as row_order
            from #{table_name}
          ) x
          where #{table_name}.id = x.id
            and #{table_name}.sort_order <> x.row_order
        sql
        return if result.cmd_tuples != 0
      end
    end

  end
end
