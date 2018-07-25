module Admitad
  module Error
    class UndefinedScope < StandardError
      def initializer(message)
        message ||= default_message
        super(message)
      end

      private

      def default_message
        'Undefined scope, allow only:' + Constants::SCOPES.join(', ')
      end
    end
  end
end
