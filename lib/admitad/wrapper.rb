module Admitad
  class Wrapper
    include Singleton
    include Admitad::Wrappers::Coupons
    include Admitad::Wrappers::Deeplinks
    include Admitad::Wrappers::Regions
    include Admitad::Wrappers::Actions
    include Admitad::Wrappers::Categories
    include Admitad::Wrappers::AdSpaces
    include Admitad::Wrappers::Currencies
    include Admitad::Wrappers::AffiliatePrograms

    private

    def initialize
      create_token
    end

    def verifying_token
      return token.attributes.stringify_keys if token.error?
      return yield unless token.expired?

      refresh_token
      verifying_token { yield }
    end

    def create_client
      @client = Client.new(token.try(:access_token))
    end

    def create_token
      @token = Token.create(Client.new.token(grant_type: :client_credentials))
      create_client
    end

    def refresh_token
      @token = Token.create(client.token(grant_type: :refresh_token, refresh_token: token.refresh_token))
      create_client
    end

    attr_reader :client, :token
  end
end
