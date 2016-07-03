require 'httparty'
require 'json'

module Yafac
  class OfferClient
    include HTTParty

    base_uri 'http://api.fyber.com/feed/v1/offers.json'

    API_KEY = ENV['API_KEY'].freeze

    PARAMS = {
      appid:       ENV['APPID'],
      format:      ENV['FORMAT'],
      device_id:   ENV['DEVICE_ID'],
      locale:      ENV['LOCALE'],
      ip:          ENV['IP'],
      offer_types: ENV['OFFER_TYPES'],
    }.freeze

    def initialize(additional_params)
      @params = PARAMS.merge(additional_params.merge({timestamp: Time.now.to_i}))
    end

  end
end
