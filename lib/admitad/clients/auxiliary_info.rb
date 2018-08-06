module Admitad
  module Clients
    class AuxiliaryInfo < Base
      def websites_regions(**params)
        assign_attributes(params)
        self.class.get('/websites/regions/', query: attributes).transform_keys(&:to_sym)
      end

      def categories(**params)
        assign_attributes(params)
        self.class.get('/categories/', query: attributes).transform_keys(&:to_sym)
      end

      private

      def allowed_params
        %i[offset limit access_token]
      end
    end
  end
end
