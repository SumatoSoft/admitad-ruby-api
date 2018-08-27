module Admitad
  module Clients
    class DeeplinkGenerator < Base
      def deeplink(**params)
        assign_attributes(params)
        path = "/deeplink/#{attributes[:w_id]}/advcampaign/#{attributes[:c_id]}/"
        response = self.class.get(path, query: query)
        response.respond_to?(:transform_keys) ? response.transform_keys(&:to_sym) : response
      end

      private

      def allowed_params
        %i[w_id c_id subid ulp]
      end

      def query
        @attributes.slice(:subid, :ulp)
      end
    end
  end
end
