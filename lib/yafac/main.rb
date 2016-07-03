require 'sinatra/base'

require_relative 'errors/fyber_api_error'
require_relative 'models/offer'
require_relative 'offer_client'

module Yafac
  class Main < Sinatra::Base

    get '/' do
      ''
    end

    post '/offers' do
      ''
    end

    configure do
      # Disable unused features to speed up
      disable :method_override
      disable :static

      # Hide exception from users
      set show_exceptions: false
      set :dump_errors, false

      # Set app's root
      set :root, File.dirname(__FILE__)
      enable :logging
    end

    error do
      status 500
      "Unknown error. " + env['sinatra.error'].message
    end

  end
end
