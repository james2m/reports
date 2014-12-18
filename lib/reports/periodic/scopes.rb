module Reports
  class Periodic
    module Scopes

      def every(*args)
        all
      end

      def for_month(date, column='created_at')
        where(["DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name column}, '%Y%m') = DATE_FORMAT(?, '%Y%m')", date])
      end

      def between_months(date1, date2, column='created_at')
        query = [
          "(DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name column}, '%Y%m') >= DATE_FORMAT(?, '%Y%m'))",
          "(DATE_FORMAT(#{quoted_table_name}.#{connection.quote_column_name column}, '%Y%m') <= DATE_FORMAT(?, '%Y%m'))"
        ].join(' AND ')
        where([date1, date2].sort.unshift(query))
      end

      def year_to_date(column='created_at')
        between_months DateTime.new(Time.zone.now.year), Time.zone.now, column
      end
    end
  end
end