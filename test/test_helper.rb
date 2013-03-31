require 'rubygems'
gem 'minitest'
require 'minitest/autorun'

# Configure Rails Environment
environment  = ENV["RAILS_ENV"] = 'test'
rails_root   = File.expand_path('../dummy4', __FILE__)

# Load dummy rails app
require File.expand_path('config/environment.rb', rails_root)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }


