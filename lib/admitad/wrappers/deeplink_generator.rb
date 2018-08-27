module Admitad
  module Wrappers
    class DeeplinkGenerator < Base
      class << self
        delegate :generate, to: :instance
      end

      def generate(**params)
        @response = client.deeplink(params)
        generate_response
      end

      private

      def generate_response
        @response.is_a?(Hash) && @response.key?(:error) ? Error.new(@response) : Response.new(deeplinks: @response)
      end

      class Response < Success
        attribute :deeplinks, Array[String]
      end
    end
  end
end
