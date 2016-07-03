ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

if ENV['RACK_ENV'] != 'production'
  require 'dotenv'
  Dotenv.load
end

require File.dirname(__FILE__) + '/lib/yafac/main'

run Yafac::Main
