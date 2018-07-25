module Admitad
  module Wrappers
    class Auth < Base
      class << self
        delegate :token, to: :instance
      end

      def token(**params)
        token_attributes = @client.token(params)
        Token.new(token_attributes)
      end
    end
  end

  class Token
    include Virtus.model

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
