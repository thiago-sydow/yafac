module Yafac
  module Errors
    class FyberApiError < StandardError
      attr_reader :code, :reason, :message

      def initialize(code, reason, message)
        @code = code
        @reason = reason
        @message = message
      end

      def to_s
        "Fyber API Error: http_status=#{@code}, reason=#{@reason}, message=#{@message}"
      end
    end
  end
end
