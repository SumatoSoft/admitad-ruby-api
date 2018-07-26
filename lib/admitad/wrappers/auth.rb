module Admitad
  module Wrappers
    class Auth < Base
      class << self
        delegate :token, :refresh_token, to: :instance
      end

      def token
        response = client.token(grant_type: :client_credentials)
        generate_response(response)
      end

      def refresh_token(refresh_token = nil)
        params = { grant_type: :refresh_token }.merge(refresh_token: refresh_token)
        response = client.token(params)
        generate_response(response)
      end

      private

      def generate_response(response)
        response.key?(:error) ? Error.new(response) : Token.new(response)
      end

      class Token < Success
        attribute :id, Integer
        attribute :username, String
        attribute :first_name, String
        attribute :last_name, String
        attribute :language, String
        attribute :access_token, String
        attribute :expires_in, Integer
        attribute :token_type, String
        attribute :scope, String
        attribute :refresh_token, String
      end
    end
  end
end
