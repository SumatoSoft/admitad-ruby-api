module Admitad
  class Wrapper
    include Singleton
    class << self
      delegate :action_statistic,
               :generate_deeplink,
               :regions,
               :categories,
               :ad_spaces_where,
               :find_ad_space_by_id,
               :affiliate_programs_where,
               :affiliate_programs_for_ad_space,
               :connect_affiliate_program,
               :disconnect_affiliate_program,
               to: :instance
    end

    def initialize
      @client = Client.new
      @token = create_token
      assign_token
    end

    def action_statistic(**params)
      check_token
      ActionsResponse.create(client.statistics_actions(params))
    end

    def generate_deeplink(**params)
      check_token
      DeeplinkResponse.create(client.deeplink(params))
    end

    def regions(**params)
      check_token
      RegionsList.create(client.websites_regions(params))
    end

    def categories(**params)
      check_token
      CategoryResponse.create(client.categories(params))
    end

    def ad_spaces_where(**params)
      check_token
      AdSpaces::Response.create(client.websites(params))
    end

    def find_ad_space_by_id(id, **params)
      check_token
      AdSpaces::Response.create(client.websites(params.merge(id: id)))
    end

    def affiliate_programs_where(**params)
      check_token
      AffiliatePrograms::Response.create(client.advcampaigns(params))
    end

    def affiliate_programs_for_ad_space(ad_space, **params)
      check_token
      id = ad_space.try(:id) || ad_space
      AffiliatePrograms::Response.create(client.advcampaigns_website(params.merge(w_id: id)))
    end

    def connect_affiliate_program(ad_space, affiliate_program)
      check_token
      w_id = ad_space.try(:id) || ad_space
      c_id = affiliate_program.try(:id) || affiliate_program
      AffiliatePrograms::Response.create(client.advcampaigns_attach(w_id: w_id, c_id: c_id))
    end

    def disconnect_affiliate_program(ad_space, affiliate_program)
      check_token
      w_id = ad_space.try(:id) || ad_space
      c_id = affiliate_program.try(:id) || affiliate_program
      AffiliatePrograms::Response.create(client.advcampaigns_detach(w_id: w_id, c_id: c_id))
    end

    private

    def check_token
      return if token&.success?

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
