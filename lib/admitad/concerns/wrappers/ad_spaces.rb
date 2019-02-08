module Admitad
  module Wrappers
    module AdSpaces
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :ad_spaces_where, :find_ad_space_by_id, to: :instance
        end
      end

      def ad_spaces_where(**params)
        verifying_token do
          client.websites(params)
        end
      end

      def find_ad_space_by_id(id, **params)
        verifying_token do
          client.websites(params.merge(id: id))
        end
      end
    end
  end
end
