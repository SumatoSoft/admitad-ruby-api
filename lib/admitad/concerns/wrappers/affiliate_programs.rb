module Admitad
  module Wrappers
    module AffiliatePrograms
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :affiliate_programs_where, :affiliate_programs_for_ad_space,
                   :connect_affiliate_program, :disconnect_affiliate_program,
                   to: :instance
        end
      end

      def affiliate_programs_where(**params)
        verifying_token do
          client.advcampaigns(params)
        end
      end

      def affiliate_programs_for_ad_space(ad_space, **params)
        id = ad_space.try(:id) || ad_space
        verifying_token do
          client.advcampaigns_website(params.merge(w_id: id))
        end
      end

      def connect_affiliate_program(ad_space, affiliate_program)
        w_id = ad_space.try(:id) || ad_space
        c_id = affiliate_program.try(:id) || affiliate_program
        verifying_token do
          client.advcampaigns_attach(w_id: w_id, c_id: c_id)
        end
      end

      def disconnect_affiliate_program(ad_space, affiliate_program)
        w_id = ad_space.try(:id) || ad_space
        c_id = affiliate_program.try(:id) || affiliate_program
        verifying_token do
          client.advcampaigns_detach(w_id: w_id, c_id: c_id)
        end
      end
    end
  end
end
