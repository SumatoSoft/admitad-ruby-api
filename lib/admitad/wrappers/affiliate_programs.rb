module Admitad
  module Wrappers
    class AffiliatePrograms < Base
      class << self
        delegate :where, :for_ad_space, :attach, :detach, to: :instance
      end

      def where(**params)
        response = client.advcampaigns(params)
        generate_response(response)
      end

      def for_ad_space(ad_space, **params)
        id = ad_space.is_a?(AdSpaces::AdSpace) ? ad_space.id : ad_space
        response = client.advcampaigns_website(params.merge(w_id: id))
        generate_response(response)
      end

      %i[attach detach].each do |api_method|
        define_method api_method do |ad_space, affiliate_programs, **params|
          w_id = ad_space.is_a?(AdSpaces::AdSpace) ? ad_space.id : ad_space
          c_id = ad_space.is_a?(AffiliatePrograms::AffiliateProgram) ? affiliate_programs.id : affiliate_programs

          response = client.send("advcampaigns_#{api_method}", params.merge(w_id: w_id, c_id: c_id))
          generate_response(response)
        end
      end

      private

      def generate_response(response)
        return Error.new(response) if response.key?(:error)
        return Success.new(response) if response.key?(:success)

        if response[:results]
          Response.new(affiliate_programs: response[:results], metadata: response[:_meta])
        else
          AffiliateProgram.new(response)
        end
      end

      class Success < Admitad::Wrappers::Success
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
        attribute :affiliate_programs, Array[AffiliateProgram]
        attribute :metadata, Hash
      end
    end
  end
end
