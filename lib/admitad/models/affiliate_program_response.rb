module Admitad
  module AffiliatePrograms
    class Success < Admitad::Success
      attribute :message, String
      attribute :success, String
    end

    class Action < Admitad::Success
      attribute :hold_time, Integer
      attribute :payment_size, String
      attribute :type, String
      attribute :name, String
      attribute :id, Integer
    end

    class Traffic < Admitad::Success
      attribute :name, String
      attribute :enabled, Boolean
    end

    class Category < Admitad::Success
      attribute :id, Integer
      attribute :parent, Category
      attribute :name, String
      attribute :language, String
    end

    class AffiliateProgram < Admitad::Success
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

      class << self
        def find(id)
          create(Wrapper.affiliate_programs_where(id: id))
        end

        def where(**params)
          params[:w_id] = params.delete(:ad_space_id)
          params[:c_id] = params.delete(:affiliate_program_id)

          attributes = if params[:w_id]
                         Wrapper.affiliate_programs_for_ad_space(params[:w_id], params)
                       else
                         Wrapper.affiliate_programs_where(params)
                       end
          Response.create(attributes)
        end

        def attach(affiliate_program, ad_space)
          AffiliatePrograms::Success.create(Wrapper.connect_affiliate_program(ad_space, affiliate_program))
        end

        def detach(affiliate_program, ad_space)
          AffiliatePrograms::Success.create(Wrapper.disconnect_affiliate_program(ad_space, affiliate_program))
        end
      end

      def attach(ad_space)
        self.class.attach(self, ad_space)
      end

      def detach(ad_space)
        self.class.detach(self, ad_space)
      end
    end

    class Response < Admitad::Success
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
