require 'virtus'
require 'admitad/config'
require 'admitad/version'
require 'admitad/constants'
Dir[File.join(__dir__, 'admitad', 'error', '*.rb')].each { |file| require file }
require 'admitad/clients/clients'
require 'admitad/wrappers/wrappers'

module Admitad
  def configuration
    @configuration ||= Config.new
  end

  def config
    config = configuration
    yield(config)
  end

  module_function :configuration, :config
end
