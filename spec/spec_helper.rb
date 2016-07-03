require 'simplecov'
require "codeclimate-test-reporter"

SimpleCov.start

require 'rspec'
require 'rack/test'
require 'byebug'

ENV['RACK_ENV'] = 'test'

require 'dotenv'
Dotenv.load

# pull in the VCR setup
require File.expand_path './support/vcr.rb', __dir__

# Requiring api files
require "./lib/yafac/main.rb"

RSpec.configure do |config|

  # Disable usage of monkey patch version of describe
  # by preventing global injection of RSpec's DSL
  config.expose_dsl_globally = false
end
