module Admitad
  class Wrapper
    include Singleton
    class << self
      delegate :action_statistic, :generate_deeplink, :regions, :coupon_categories,
               :categories, :ad_spaces_where, :find_ad_space_by_id, :coupons, :find_coupon,
               :affiliate_programs_where, :affiliate_programs_for_ad_space,
               :connect_affiliate_program, :disconnect_affiliate_program,
               to: :instance
    end

    def initialize
      @client = Client.new
      @token = create_token
      assign_token
    end

    def coupons(**params)
      check_token
      client.coupons(params)
    end

    def find_coupon(id)
      check_token
      client.coupons(id: id)
    end

    def coupon_categories(**params)
      check_token
      client.coupons_categories(params)
    end

    def find_coupon_for_website(id, **params)
      check_token
      client.coupons_website(params.merge(c_id: id))
    end

    def coupons_for_website(**params)
      check_token
      client.coupons_website(params)
    end

    def action_statistic(**params)
      check_token
      client.statistics_actions(params)
    end

    def generate_deeplink(**params)
      check_token
      client.deeplink(params)
    end

    def regions(**params)
      check_token
      client.websites_regions(params)
    end

    def categories(**params)
      check_token
      client.categories(params)
    end

    def ad_spaces_where(**params)
      check_token
      client.websites(params)
    end

    def find_ad_space_by_id(id, **params)
      check_token
      client.websites(params.merge(id: id))
    end

    def affiliate_programs_where(**params)
      check_token
      client.advcampaigns(params)
    end

    def affiliate_programs_for_ad_space(ad_space, **params)
      check_token
      id = ad_space.try(:id) || ad_space
      client.advcampaigns_website(params.merge(w_id: id))
    end

    def connect_affiliate_program(ad_space, affiliate_program)
      check_token
      w_id = ad_space.try(:id) || ad_space
      c_id = affiliate_program.try(:id) || affiliate_program
      client.advcampaigns_attach(w_id: w_id, c_id: c_id)
    end

    def disconnect_affiliate_program(ad_space, affiliate_program)
      check_token
      w_id = ad_space.try(:id) || ad_space
      c_id = affiliate_program.try(:id) || affiliate_program
      client.advcampaigns_detach(w_id: w_id, c_id: c_id)
    end

    private

    def check_token
      return if token&.success? && !token.expired?

      @token = token.expired? ? refresh_token : create_token
      assign_token
    end

    def assign_token
      @client = Client.new(token.try(:access_token))
    end

    def create_token
      Token.create(client.token(grant_type: :client_credentials))
    end

    def refresh_token
      Token.create(client.token(grant_type: :refresh_token, refresh_token: token.refresh_token))
    end

    attr_reader :client, :token
  end
end
