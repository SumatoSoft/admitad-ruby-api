module Admitad
  module AffiliatePrograms
    class Success < Admitad::Success
      attribute :message, String
      attribute :success, String
    end

    class Action < Success
      attribute :hold_time, Integer
      attribute :payment_size, String
      attribute :type, String
      attribute :name, String
      attribute :id, Integer
    end

    class Traffic < Success
      attribute :name, String
      attribute :enabled, Boolean
    end

    class Category < Success
      attribute :id, Integer
      attribute :parent, Category
      attribute :name, String
      attribute :language, String
    end

    class AffiliateProgram < Success
      attribute :goto_cookie_lifetime, Integer
      attribute :rating, String
      attribute :exclusive, Boolean
      attribute :image, String
      attribute :actions, Array[Action]
      attribute :avg_money_transfer_time, Integer
      attribute :currency, String
      attribute :activation_date, String
      attribute :cr, Float
      attribute :max_hold_time, String
      attribute :id, Integer
      attribute :avg_hold_time, Integer
      attribute :ecpc, Float
      attribute :connection_status, String
      attribute :gotolink, String
      attribute :site_url, String
      attribute :regions, Array
      attribute :actions_detail, Array
      attribute :epc_trend, String
      attribute :geotargeting, Boolean
      attribute :products_xml_link, String
      attribute :status, String
      attribute :coupon_iframe_denied, Boolean
      attribute :traffics, Array[Traffic]
      attribute :description, String
      attribute :cr_trend, String
      attribute :raw_description, String
      attribute :modified_date, String
      attribute :denynewwms, Boolean
      attribute :moderation, Boolean
      attribute :categories, Array[Category]
      attribute :name, String
      attribute :retag, Boolean
      attribute :products_csv_link, String
      attribute :feeds_info, Array
      attribute :landing_code, String
      attribute :ecpc_trend, String
      attribute :landing_title, String
      attribute :epc, Float
      attribute :allow_deeplink, Boolean
      attribute :show_products_links, Boolean
    end

    class Response < Success
      attribute :results, Array[AffiliateProgram]
      attribute :_meta, Hash

      def self.create(attributes)
        if Constants::ERRORS.any? { |error| attributes.key?(error) }
          Error.new(attributes)
        elsif attributes['results']
          new(attributes)
        elsif attributes['success']
          Success.new(attributes)
        else
          AffiliateProgram.new(attributes)
        end
      end

      alias affiliate_programs results
      alias metadata _meta
    end
  end
end
