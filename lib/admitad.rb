require 'virtus'
require 'admitad/config'
require 'admitad/version'
require 'admitad/constants'
require 'admitad/models/result'

Dir[File.join(__dir__, 'admitad', 'models', '*.rb')].map(&method(:require))
Dir[File.join(__dir__, 'admitad', '**', '*.rb')].map(&method(:require))

module Admitad
  def configuration
    @configuration ||= Config.new
  end

  def config
    config = configuration
    yield(config)
  end

  module_function :configuration, :config

  AdSpace = AdSpaces::AdSpace
  AffiliateProgram = AffiliatePrograms::AffiliateProgram
  Coupon = Coupons::Coupon
  Currency = Currencies::Currency
end

AdmitadAPI = Admitad
