require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  # Default cassette options
  c.default_cassette_options = { :record => :new_episodes }

  c.ignore_hosts 'codeclimate.com'
end
