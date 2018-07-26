require 'virtus'
require 'admitad/config'
require 'admitad/version'
require 'admitad/constants'
require 'admitad/clients/base'
require 'admitad/wrappers/base'

def require_folder(folder, **args)
  files = Dir[File.join(__dir__, 'admitad', folder, '*.rb')]
  files.reject! { |file| file[args[:reject]] } if args[:reject]
  files.each { |file| require file }
end

require_folder('error')
require_folder('clients', reject: 'base')
require_folder('wrappers', reject: 'base')

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
