require 'csv'
require 'reports/row'
require 'reports/base'
require 'reports/scoped'
require 'reports/periodic'
require 'reports/periodic/scopes'
require 'report'
require 'reports/version'
require 'reports/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
module Reports

  def self.all
    @all ||= Base.descendants.reject { |mod| ["Reports::Scoped", "Reports::Periodic"].include?(mod.to_s) }
  end

  def self.reload #:nodoc:
    load_paths = [File.expand_path('app/reports', Rails.root)]

    load_paths.each do |path|
      Dir[File.join(path, '**', '*.rb')].sort.each do |file|
        load file
      end
    end

  end

end