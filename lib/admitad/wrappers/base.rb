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
  end
end
