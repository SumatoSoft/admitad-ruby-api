module Admitad
  module Wrappers
    class AdSpaces < Base
      class << self
        delegate :where, :find_by_id, to: :instance
      end

      def where(**params)
        response = client.websites(params)
        generate_response(response)
      end

      def find_by_id(id, **params)
        response = client.websites(params.merge(id: id))
        generate_response(response).first
      end

      private

      def generate_response(response)
        return Error.new(response) if response.key?('error')

        Array(response[:results]).map { |ad_space_attributes| AdSpace.new(ad_space_attributes) }
      end

      class Region < Success
        attribute :id, Integer
        attribute :region, String
      end

      class Category < Success
        attribute :id, Integer
        attribute :parent, Category
        attribute :name, String
        attribute :language, String
      end

      class AdSpace < Success
        attribute :id, Integer
        attribute :regions, Array[Region]
        attribute :categories, Array[Category]
        attribute :status, String
        attribute :account_id, String
        attribute :kind, String
        attribute :is_old, Boolean
        attribute :name, String
        attribute :collecting_method, String
        attribute :verification_code, String
        attribute :mailing_targeting, Boolean
        attribute :site_url, String
        attribute :db_size, String
        attribute :adservice, String
        attribute :creation_date, String
        attribute :validation_passed, Boolean
        attribute :description, String
      end
    end
  end
end
