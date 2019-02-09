module Admitad
  class Config
    include ActiveSupport::Configurable

    config_accessor :client_id, :scope, :client_secret

    def initialize(**options)
      options.each do |key, value|
        config.send("#{key}=", value)
      end
    end
  end
end
