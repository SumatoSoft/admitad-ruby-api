module Admitad
  module Wrappers
    class DeeplinkGenerator < Base
      class << self
        delegate :generate, to: :instance
      end

      def generate(**params)
        @params = params
        return Error.new(error: error) if error.present?

        @response = client.deeplink(@params)
        generate_response
      end

      private

      def generate_response
        return Error.new(@response) if @response.is_a?(Hash) && @response.key?(:error)

        @response.first
      end

      def allowed_params
        client.allowed_params
      end

      def error
        @error ||= allowed_params.reject { |attribute| @params[attribute] }
                                 .map { |attribute| "#{attribute.capitalize} is required" }
                                 .join('. ')
      end
    end
  end
end
