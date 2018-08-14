module Admitad
  module Clients
    class Statistics < Base
      def actions(**params)
        assign_attributes(params)
        self.class.get('/statistics/actions/', query: attributes).transform_keys(&:to_sym)
      end

      private

      def allowed_params
        %i[
          offset
          limit
          date_start
          date_end
          closing_date_start
          closing_date_end
          status_updated_start
          status_updated_end
          website
          campaign
          subid
          subid1
          subid2
          subid3
          subid4
          source
          status
          keyword
          action
          action_id
          banner
          action_type
          processed
          paid
          total
          order_by
        ]
      end
    end
  end
end
