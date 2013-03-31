module Reports
  class Base

    class InvalidPeriodError < ArgumentError; end
    class NotImplementedError < ::NotImplementedError; end

    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    def initialize(options = {})
      @options = options
      options.stringify_keys!
      @scopes = Array(options[:scopes])
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

    def new_record?; true; end
    def persisted?; false; end

    def stream
      raise NotImplementedError
    end

    def title
      @title ||= I18n.t 'title', :scope => ['reports', type], :default => "#{type} report".titleize
    end

    def type
      self.class.name.demodulize.underscore.gsub(/_report$/, '')
    end

    def valid?; true; end

    private

    def add_report_specific_scopes
    end

    def base_relation
      @base_relation ||= type.classify.constantize
    end

    def rows
      @rows ||= @scopes.inject(base_relation) do |relation, scope|
        relation.send(*scope)
      end
    end

  end
  # Base
end
# Reports
