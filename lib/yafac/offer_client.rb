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

    def get_offers
      response = self.class.get('/', query: @params.merge(hashkey: hash_key))
      parsed_response = JSON.parse(response.body)

      if response.code != 200
        raise Yafac::Errors::FyberApiError.new(response.code, parsed_response['code'], parsed_response['message'])
      else
        ''
      end

    end

    def hash_key
      hash_key = @params.map { |key, value| "#{key}=#{value}" }.sort
      hash_key << API_KEY

      Digest::SHA1.hexdigest(hash_key.join('&'))
    end

  end
end
