require 'httparty'

module Admitad
  module Clients
    class Base
      include HTTParty
      headers 'Content-Type' => 'application/x-www-form-urlencoded'
      debug_output $stdout
      base_uri Constants::BASE_URI

      attr_reader :attributes

      def initialize
        @client_id     = Admitad.configuration.client_id
        @client_secret = Admitad.configuration.client_secret
        @scope         = Admitad.configuration.scope
      end

      private

      def assign_attributes(**attributes)
        @attributes = attributes.slice(*allowed_params)

        attributes.each do |key, value|
          instance_variable_set("@#{key}", value) if value
        end

        self.class.headers['Authorization'] = "Bearer #{@access_token}" if @access_token && !is_a?(Auth)
      end

      def allowed_params
        raise "You must override #allowed_params in class #{self.class.name} to add parameters filter"
      end
    end
  end
end
