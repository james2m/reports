class Report

  include ActiveModel::Model
  attr_accessor :type

  delegate :title, :from, :to, :period, :month, :file_name, :stream, to: :report, allow_nil: true

  def self.all
    Reports.all.map { |klass| new('type' => String(klass)) }
  end

  def initialize(options = {})
    @type = String(options.delete('type'))

    klass = Reports.all.find { |mod| String(mod) == @type }

    @report = klass.new(options) if klass
  end

  def report
    @report
  end

  def new_record?; true; end
  def persisted?; false; end

end