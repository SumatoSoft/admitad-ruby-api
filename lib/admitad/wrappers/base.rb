module Admitad
  module Wrappers
    class Base
      include Singleton

      def initialize
        client_class = Object.const_get(self.class.to_s.gsub('Wrappers', 'Clients'))
        @client = client_class.new
      end

      attr_reader :client
    end

    class Result
      include Virtus.model

      def success?
        is_a? Success
      end

      def error?
        is_a? Error
      end
    end

    class Error < Result
      attribute :error_description, String
      attribute :error_code, Integer
      attribute :error, String
    end

    class Success < Result; end
  end
end
