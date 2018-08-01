module Admitad
  module Clients
    class AffiliatePrograms < Base
      def advcampaigns(**params)
        assign_attributes(params)
        path = '/advcampaigns/'
        path << "#{@id}/" if @id

        self.class.get(path, query: attributes).transform_keys(&:to_sym)
      end

      def advcampaigns_website(**params)
        assign_attributes(params)

        path = '/advcampaigns/'
        path << "#{@c_id}/" if @c_id
        path << 'website/'
        path << "#{@w_id}/" if @w_id

        self.class.get(path, query: attributes).transform_keys(&:to_sym)
      end

      %w[attach detach].each do |api_method|
        define_method "advcampaigns_#{api_method}" do |**params|
          assign_attributes(params)

          path = '/advcampaigns/'
          path << "#{@c_id}/" if @c_id
          path << "#{api_method}/"
          path << "#{@w_id}/" if @w_id

          self.class.post(path, body: attributes).transform_keys(&:to_sym)
        end
      end

      private

      def allowed_params
        %i[offset limit language website has_tool traffic_id id connection_status w_id c_id]
      end
    end
  end
end
