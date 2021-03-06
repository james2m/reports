module Reports
  class Base

    class NotImplementedError < ::NotImplementedError; end

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    def initialize(options = {})
      @options = options
      options.stringify_keys!
    end

    def file
      file = File.open(file_name, "wb", :row_sep => "\r\n")
      file.puts stream
      file.close
      file
    end

    def file_name
      "#{title.parameterize}.csv"
    end

    def stream
      @stream ||= begin
        CSV.generate(:row_sep => "\r\n") do |csv|
          csv << headers
          rows.each { |row| csv << to_columns(row) }
        end
      end
    end

    def title
      @title ||= I18n.t 'title', { :scope => ['reports', type_name], :default => "#{type_name} report".titleize }.merge(locale_params)
    end

    def base_class
      type_name.classify.constantize
    end

    def type_name
      self.class.name.demodulize.underscore.gsub(/_report$/, '')
    end

    def new_row(row)
      Row.new(row)
    end

    def self.find(*args); nil; end

    private

    def locale_params
      @locale_params ||= {}
    end

    def rows
      raise NotImplementedError
    end

    def headers
      raise NotImplementedError
    end

    def to_columns(row)
      row.to_columns
    end

    def new_record?; true; end
    def persisted?; false; end

  end
  # Base
end
# Reports