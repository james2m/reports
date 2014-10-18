module Reports
  class Periodic
      module Scopes

      def for_month(date)
        where(["DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name 'created_at'}, '%Y%m') = DATE_FORMAT(?, '%Y%m')", date])
      end

      def between_months(date1, date2)
        query = [
          "(DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name 'created_at'}, '%Y%m') >= DATE_FORMAT(?, '%Y%m'))",
          "(DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name 'created_at'}, '%Y%m') <= DATE_FORMAT(?, '%Y%m'))"
        ].join(' AND ')
        where([date1, date2].sort.unshift(query))
      end

      def year_to_date
        between_months DateTime.new(Time.zone.now.year), Time.zone.now
      end
    end
  end
end