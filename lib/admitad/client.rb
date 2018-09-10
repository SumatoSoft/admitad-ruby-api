require 'httparty'

module Admitad
  class Client
    include HTTParty
    headers 'Content-Type' => 'application/x-www-form-urlencoded'
    debug_output $stdout
    base_uri Constants::BASE_URI

    def initialize(access_token = nil)
      @client_id     = Admitad.configuration.client_id
      @client_secret = Admitad.configuration.client_secret
      @scope         = Admitad.configuration.scope || Constants::SCOPES.join(' ')
      @access_token  = access_token
    end

    def coupons_categories(**params)
      path = '/coupons/categories/'
      path << "#{params[:id]}/"
      get(path, query: params.slice(*Constants::BASE_PARAMS))
    end

    def coupons(**params)
      path = '/coupons/'
      path << "#{params[:id]}/" if params[:id]
      get(path, query: params.slice(*Constants::BASE_PARAMS))
    end

    def coupons_website(**params)
      path = '/coupons/'
      path << "#{params[:c_id]}/" if params[:c_id]
      path << 'website/'
      path << "#{params[:w_id]}/" if params[:w_id]

      get(path, query: params.slice(*Constants::COUPONS_PARAMS))
    end

    def websites(**params)
      path = '/websites/'
      path << "#{params[:id]}/" if params[:id]
      get(path, query: params.slice(*Constants::AD_SPACE_PARAMS))
    end

    def advcampaigns(**params)
      path = '/advcampaigns/'
      path << "#{params[:id]}/" if params[:id]

      get(path, query: params.slice(*Constants::AFFILIATE_PROGRAMS_PARAMS))
    end

    def advcampaigns_website(**params)
      path = '/advcampaigns/'
      path << "#{params[:c_id]}/" if params[:c_id]
      path << 'website/'
      path << "#{params[:w_id]}/" if params[:w_id]

      get(path, query: params.slice(*Constants::AFFILIATE_PROGRAMS_PARAMS))
    end

    %w[attach detach].each do |api_method|
      define_method "advcampaigns_#{api_method}" do |**params|
        path = '/advcampaigns/'
        path << "#{params[:c_id]}/" if params[:c_id]
        path << "#{api_method}/"
        path << "#{params[:w_id]}/" if params[:w_id]

        post(path, body: params.slice(*Constants::AFFILIATE_PROGRAMS_PARAMS))
      end
    end

    def token(**params)
      self.class.post('/token/', body: token_body(params), headers: token_headers(params))
    end

    def statistics_actions(**params)
      get('/statistics/actions/', query: params.slice(*Constants::STATISTIC_ACTIONS_PARAMS))
    end

    def deeplink(**params)
      get("/deeplink/#{params[:w_id]}/advcampaign/#{params[:c_id]}/", query: params.slice(:subid, :ulp))
    end

    def websites_regions(**params)
      get('/websites/regions/', query: params.slice(*Constants::BASE_PARAMS))
    end

    def categories(**params)
      get('/categories/', query: params.slice(*Constants::BASE_PARAMS))
    end

    private

    def post(path, options = {}, &block)
      options[:headers] = { Authorization: "Bearer #{access_token}" }
      self.class.post(path, options, &block)
    end

    def get(path, options = {}, &block)
      options[:headers] = { Authorization: "Bearer #{access_token}" }
      self.class.get(path, options, &block)
    end

    def token_body(params)
      if params[:grant_type] == :client_credentials
        params.slice(:grant_type).merge(client_id: @client_id, scope: @scope)
      else
        params.slice(:refresh_token, :grant_type).merge(client_id: @client_id, client_secret: @client_secret)
      end
    end

    def token_headers(params)
      if params[:grant_type] == :client_credentials
        { Authorization: "Basic #{Base64.strict_encode64("#{@client_id}:#{@client_secret}")}" }
      else
        self.class.headers
      end
    end

    attr_reader :access_token
  end
end
