module Admitad
  module Wrappers
    module Categories
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :categories, to: :instance
        end
      end

      def categories(**params)
        verifying_token do
          client.categories(params)
        end
      end
    end
  end
end
