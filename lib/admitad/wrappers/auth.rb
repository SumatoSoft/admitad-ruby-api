module Admitad
  module Wrappers
    class Auth < Base
      class << self
        delegate :token, to: :instance
        delegate :refresh_token, to: :instance
      end

      def token(**params)
        response = client.token(params)
        generate_response(response)
      end

      def refresh_token(**params)
        response = client.refresh_token(params)
        generate_response(response)
      end

      private

      def generate_response(response)
        response.key?('error') ? Error.new(response) : Token.new(response)
      end

      class Token < Success
        attribute :username, String
        attribute :first_name, String
        attribute :last_name, String
        attribute :language, String
        attribute :access_token, String
        attribute :expires_in, Integer
        attribute :token_type, String
        attribute :scope, String
        attribute :id, Integer
        attribute :refresh_token, String
      end
    end
  end
end
