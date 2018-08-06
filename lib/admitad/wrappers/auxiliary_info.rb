module Admitad
  module Wrappers
    class AuxiliaryInfo < Base
      class << self
        delegate :regions, :categories, to: :instance
      end

      def regions(**params)
        response = client.websites_regions(params)
        generate_response(response, :regions)
      end

      def categories(**params)
        response = client.categories(params)
        generate_response(response, :categories)
      end

      private

      def generate_response(response, type)
        return Error.new(response) if response.key?(:error)

        case type
        when :regions
          RegionsList.new(response)
        when :categories
          Response.new(categories: response[:results], metadata: response[:_meta])
        else
          Error.new
        end
      end

      class RegionsList < Success
        attribute :results, Array

        alias value results
      end

      class Category < Success
        attribute :id, Integer
        attribute :parent, Category
        attribute :name, String
        attribute :language, String
      end

      class Response < Success
        attribute :categories, Array[Category]
        attribute :metadata, Hash
      end
    end
  end
end
