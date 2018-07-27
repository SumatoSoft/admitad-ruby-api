module Admitad
  module Wrappers
    class AuxiliaryInfo < Base
      class << self
        delegate :regions, to: :instance
      end

      def regions(**params)
        response = client.websites_regions(params)
        generate_response(response)
      end

      private

      def generate_response(response)
        response.key?(:error) ? Error.new(response) : RegionsList.new(response)
      end

      class RegionsList < Success
        attribute :results, Array

        alias value results
      end
    end
  end
end
