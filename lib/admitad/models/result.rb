module Admitad
  class Result
    include Virtus.model

    def success?
      is_a? Success
    end

    def error?
      is_a? Error
    end

    def self.create(attributes)
      Constants::ERRORS.none? { |error| attributes.key?(error) } ? new(attributes) : Error.new(attributes)
    end
  end

  class Error < Result
    attribute :error_description, String
    attribute :error_code, Integer
    attribute :error, String
  end

  class Success < Result; end
end
