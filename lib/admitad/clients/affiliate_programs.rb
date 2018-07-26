module Admitad
  module Clients
    class AffiliatePrograms < Base
      def advcampaigns(**params)
        assign_attributes(params)
        self.class.get('/advcampaigns/', query: attributes).to_h.map { |k, v| [k.to_sym, v] }.to_h
      end

      def advcampaigns_website(**params)
        assign_attributes(params)
        path = "/advcampaigns/#{"#{@c_id}/" if @c_id}website/#{@w_id}/"
        self.class.get(path, query: attributes).to_h.map { |k, v| [k.to_sym, v] }.to_h
      end

      private

      def allowed_params
        %i[offset limit language website has_tool traffic_id id connection_status w_id c_id]
      end
    end
  end
end
