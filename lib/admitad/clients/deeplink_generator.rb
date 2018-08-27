module Admitad
  module Clients
    class DeeplinkGenerator < Base
      def deeplink(**params)
        assign_attributes(params)
        path = "/deeplink/#{attributes[:w_id]}/advcampaign/#{attributes[:c_id]}/"
        response = self.class.get(path, query: query)
        response.is_a?(Hash) ? response.transform_keys(&:to_sym) : response
      end

      def allowed_params
        %i[w_id c_id subid ulp]
      end

      private

      def query
        @attributes.slice(:subid, :ulp)
      end
    end
  end
end
