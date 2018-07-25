require 'base64'

module Admitad
  module Clients
    class Auth < Base
      ALLOWED_PARAMS = {
        client_credentials: %i[grant_type client_id scope],
        refresh_token: %i[grant_type client_id refresh_token client_secret]
      }.freeze

      def token(**params)
        @grant_type = :client_credentials
        @body = token_body.merge(params)

        self.class.post('/token/', header: token_header, body: body)
      end

      def refresh_token(**params)
        @grant_type = :refresh_token
        @body = refresh_token_body.merge(params)

        self.class.post('/token/', body: body)
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

      def refresh_token_body
        token_body.merge(client_secret: @client_secret)
      end

      def data_b64_encoded
        Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      end

      def allowed_params
        ALLOWED_PARAMS[@grant_type]
      end
    end
  end
end
