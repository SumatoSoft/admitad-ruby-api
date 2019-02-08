module Admitad
  module Wrappers
    module Actions
      extend ActiveSupport::Concern

      included do
        class << self
          delegate :action_statistic, to: :instance
        end
      end

      def action_statistic(**params)
        verifying_token do
          client.statistics_actions(params)
        end
      end
    end
  end
end
