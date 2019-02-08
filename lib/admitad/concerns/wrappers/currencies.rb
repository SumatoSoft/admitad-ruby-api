module Admitad
  module Wrappers
    module Currencies
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :currencies, :currencies_rate, to: :instance
        end
      end

      def currencies(**params)
        verifying_token do
          client.currencies(params)
        end
      end

      def currencies_rate(**params)
        verifying_token do
          client.currencies_rate(params)
        end
      end
    end
  end
end
