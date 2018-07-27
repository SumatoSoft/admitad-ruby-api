module Admitad
  module Clients
    class AdSpaces < Base
      def websites(**params)
        assign_attributes(params)
        self.class.get('/websites/', query: attributes).transform_keys(&:to_sym)
      end

      private

      def allowed_params
        %i[offset limit status campaign_status access_token id]
      end
    end
  end
end
