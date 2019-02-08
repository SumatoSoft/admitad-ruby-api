module Admitad
  class Wrapper
    include Singleton
    include Wrappers::Coupons
    include Wrappers::Deeplinks
    include Wrappers::Regions
    include Wrappers::Actions
    include Wrappers::Categories
    include Wrappers::AdSpaces
    include Wrappers::Currencies
    include Wrappers::AffiliatePrograms

    private

    def initialize
      create_token
    end

    def verifying_token(&block)
      return token.attributes.stringify_keys if token.error?
      return block.call unless token.expired?

      refresh_token
      verifying_token block
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
