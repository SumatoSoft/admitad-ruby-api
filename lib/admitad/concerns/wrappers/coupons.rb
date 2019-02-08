module Admitad
  module Wrappers
    module Coupons
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :coupon_categories, :coupons, :find_coupon,
                   :find_coupon_for_website, :coupons_for_website,
                   to: :instance
        end
      end

      def coupons(**params)
        verifying_token do
          client.coupons(params)
        end
      end

      def find_coupon(id)
        verifying_token do
          client.coupons(id: id)
        end
      end

      def coupon_categories(**params)
        verifying_token do
          client.coupons_categories(params)
        end
      end

      def find_coupon_for_website(id, **params)
        verifying_token do
          client.coupons_website(params.merge(c_id: id))
        end
      end

      def coupons_for_website(**params)
        verifying_token do
          client.coupons_website(params)
        end
      end
    end
  end
end
