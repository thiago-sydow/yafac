source 'https://rubygems.org'

ruby '2.3.0'

gem 'sinatra'
gem 'unicorn'
gem 'httparty'

group :test, :development do
  gem 'rspec'
  gem 'byebug'
  gem 'rake'
  gem 'dotenv'
end

group :test do
  gem 'timecop'
  gem 'rack-test'
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', require: false
end
