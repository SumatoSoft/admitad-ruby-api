module Admitad
  module Coupons
    class Field < Success
      attribute :name, String
      attribute :id, Integer
    end

    class Category < Field
      class << self
        def where(**params)
          CategoriesList.create(Wrapper.coupon_categories(params))
        end

        def find(id)
          create(Wrapper.coupon_categories(id: id))
        end
      end
    end

    class Type < Field; end
    class Campaign < Field; end

    class CategoriesList < Success
      attribute :results, Array[Category]
      attribute :_meta, Hash

      alias categories results
      alias metadata _meta
    end

    class Coupon < Success
      attribute :status, String
      attribute :rating, String
      attribute :campaign, Campaign
      attribute :name, String
      attribute :short_name, String
      attribute :date_end, String
      attribute :date_start, String
      attribute :exclusive, Boolean
      attribute :discount, String
      attribute :species, String
      attribute :categories, Array[Category]
      attribute :image, String
      attribute :id, Integer
      attribute :regions, Array[String]
      attribute :types, Array[Type]
      attribute :description, String

      class << self
        def find(id)
          create(Wrapper.find_coupon(id))
        end

        def where(**params)
          attributes = params[:ad_space_id] ? Wrapper.coupons_for_website(**params) : Wrapper.coupons(params)
          Response.create(attributes)
        end
      end
    end

    class Response < Success
      attribute :results, Array[Coupon]
      attribute :_meta, Hash

      alias affiliate_programs results
      alias metadata _meta
    end
  end
end
