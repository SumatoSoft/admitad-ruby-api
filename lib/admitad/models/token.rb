require 'active_support/time'

module Admitad
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

    def initialize(attributes)
      attributes[:expires_at] = Time.current.to_i + attributes['expires_in']
      super(attributes)
    end

    def expired?
      (Time.current + Constants::BUFFER_TIME).to_i > @expires_at
    end
  end
end
