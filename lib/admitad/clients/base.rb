require 'httparty'

module Admitad
  module Clients
    class Base
      include HTTParty
      headers 'Content-Type' => 'application/x-www-form-urlencoded'
      debug_output $stdout
      base_uri Constants::BASE_URI

      def initialize
        @client_id     = Admitad.configuration.client_id
        @client_secret = Admitad.configuration.client_secret
        @scope         = Admitad.configuration.scope
        @grant_type    = Constants::GRANT_TYPE
      end
    end
  end
end
