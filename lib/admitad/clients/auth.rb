require 'base64'

module Admitad
  module Clients
    class Auth < Base
      def token(**params)
        self.class.post('/token/', header: token_header, body: token_body.merge(params))
      end

      private

      def token_header
        self.class.headers.merge!('Authorization' => "Basic #{data_b64_encoded}")
      end

      def token_body
        {
          grant_type: @grant_type,
          client_id: @client_id,
          scope: @scope
        }
      end

      def data_b64_encoded
        Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      end
    end
  end
end
