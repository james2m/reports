module Reports

  class Periodic < Scoped

    class InvalidPeriodError < ArgumentError; end

    class Period < Struct.new(:type, :title); end

    attr_reader :period
    attr_accessor :month, :from, :to

    class << self

      def periods
        @periods ||= ['for_month', 'between_months', 'year_to_date', 'all'].map do |period|
          title = I18n.t('title', { scope: ['reports', 'periods', period], default: period.titleize })
          Period.new(period, title)
        end
      end

    end

    def initialize(options = {})
      super
      @period = String(options['period'] || 'all')
      extract_date_options(options)

      if periodic_scopes_on_base_class
        @scopes << period_scope
        add_period_scopes_to_base_relation
      end
    end

    def period_name
      @period_name ||= begin
        options = [:month, :to, :from].inject({}) do |hash, option|
          value = send(option)
          hash[option] = value.to_formatted_s(:month_and_year) if value.is_a?(DateTime)
          hash
        end

        I18n.t(period, { scope: ['reports', 'periods'], default: "#{period}".titleize }.merge(options))
      end
    end

    def valid?
      (period == 'for_month' && month) \
      || (period == 'between_months' && to && from) \
      || (period == 'year_to_date') \
      || (period == 'all')
    end

    private

    def periodic_scopes_on_base_class
      true
    end

    def add_period_scopes_to_base_relation
      scopes = Scopes.dup
      scopes.instance_methods.each do |method_name|
        scopes.send(:remove_method, method_name) if base_relation.respond_to?(method_name)
      end
      base_relation.extend scopes
    end

    def extract_date(attrs)
      case attrs
      when DateTime then attrs.to_date
      when Date then attrs
      when ActiveSupport::TimeWithZone then attrs.to_date
      when Array then Date.civil(*attrs)
      else Date.today
      end
    end

    def extract_date_options(options)
      # construct a date for to, from & month using the fields created by select_date view helper or fall back to options[:to] etc
      ['month', 'to', 'from'].each do |option|
        date_options = options.slice("#{option}(1i)", "#{option}(2i)", "#{option}(3i)")
        date = date_options.length == 3 ? date_options.sort_by(&:first).map{ |arry| arry.last.to_i } : options[option]
        instance_variable_set( "@#{option}", extract_date(date) )
      end
    end

    def period_scope
      case @period
      when 'all','year_to_date' then [@period]
      when 'for_month', 'between_months' then [@period] + period_scope_parameters
      else raise InvalidPeriodError, 'must be either :for_month, :between_months, :year_to_date, or :all'
      end
    end

    def period_scope_parameters
      period == 'for_month' ? [month] : [from, to]
    end

  end
  # Periodic

end
# Reports
