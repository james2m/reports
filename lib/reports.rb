require 'csv'
require 'reports/base'
require 'reports/scoped'
require 'reports/version'
require 'reports/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3
