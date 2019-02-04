module Admitad
  module Wrappers
    module Deeplinks
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :generate_deeplink, to: :instance
        end
      end

      def generate_deeplink(**params)
        verifying_token do
          client.deeplink(params)
        end
      end
    end
  end
end
