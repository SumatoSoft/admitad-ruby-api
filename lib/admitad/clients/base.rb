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
      end

      private

      def body
        @body ||= @body.map { |k, v| [k.to_sym, v] }.to_h.slice(*allowed_params)
      end

      def allowed_params
        raise "You must override #allowed_params in class #{self.class.name} to add parameters filter"
      end
    end
  end
end
