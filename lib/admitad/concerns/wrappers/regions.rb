module Admitad
  module Wrappers
    module Regions
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :regions, to: :instance
        end
      end

      def regions(**params)
        verifying_token do
          client.websites_regions(params)
        end
      end
    end
  end
end
