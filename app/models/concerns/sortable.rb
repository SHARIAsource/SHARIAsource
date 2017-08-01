module Sortable
  extend ActiveSupport::Concern

  included do
    def self.sort_by_dates
      update_sort('created_at')
    end

    def self.sort_by_names(item_id = nil)
      update_sort('name', item_id)
    end

    def self.update_sort(column_name, item_id = nil)
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
            and (#{table_name}.sort_order <> x.row_order or #{table_name}.sort_order is null)
            #{
               if columns.map(&:name).include? "parent_id"
                 if item_id.present?
                   "and #{table_name}.parent_id = #{item_id}"
                 else
                   "and #{table_name}.parent_id is null"
                 end
               end
            }
        sql
        Rails.logger.info "Updated #{result.cmd_tuples} rows."
        return if result.cmd_tuples != 0
      end
    end

  end
end
