module Admitad
  module AdSpaces
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

      class << self
        def where(**params)
          Response.create(Wrapper.ad_spaces_where(params))
        end

        def find(id)
          create(Wrapper.find_ad_space_by_id(id))
        end
      end
    end

    class Response < Success
      attribute :results, Array[AdSpace]
      attribute :_meta, Hash

      def self.create(attributes)
        if Constants::ERRORS.any? { |error| attributes.key?(error) }
          Error.new(attributes)
        elsif attributes['results']
          new(attributes)
        else
          AdSpace.new(attributes)
        end
      end

      alias ad_spaces results
      alias metadata _meta
    end
  end
end
