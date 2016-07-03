require 'sinatra/base'

require_relative 'errors/fyber_api_error'
require_relative 'models/offer'
require_relative 'offer_client'

module Yafac
  class Main < Sinatra::Base

    get '/' do
      erb ''
    end

    post '/offers' do
      client = OfferClient.new(permitted_params)
      erb :offers, locals: { offers: client.get_offers }
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

    error Yafac::Errors::FyberApiError do |error|
      erb :fyber_error_response, locals: { error: error }
    end

    error do
      status 500
      "Unknown error. " + env['sinatra.error'].message
    end

    def permitted_params
      { uid: params['uid'], pub0: params['pub0'], page: params['page'] }
    end

  end
end
