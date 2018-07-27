require 'base64'

module Admitad
  module Clients
    class Auth < Base
      def token(**params)
        assign_attributes(params)
        response = self.class.post('/token/', body: body).transform_keys(&:to_sym)
        assign_attributes(response)
        response
      end

      private

      def body
        body = { grant_type: @grant_type, client_id: @client_id, scope: @scope }

        if client_credentials?
          self.class.headers['Authorization'] = "Basic #{@basic}"
          body
        else
          self.class.headers.delete('Authorization')
          body.merge(client_secret: @client_secret, refresh_token: @refresh_token)
        end
      end

      def assign_attributes(**attributes)
        super(attributes)

        @basic = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      end

      def client_credentials?
        @grant_type == :client_credentials
      end

      def allowed_params
        %i[grant_type client_id scope refresh_token client_secret access_token]
      end
    end
  end
end
