ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require File.dirname(__FILE__) + '/lib/yafac/main'

run Yafac::Main
