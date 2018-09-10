module Admitad
  class Deeplinks < Success
    attribute :deeplinks, Array[String]

    def self.create(**params)
      params = params.merge(c_id: params[:affiliate_program_id], w_id: params[:ad_space_id])
      attributes = Wrapper.generate_deeplink(params)
      Constants::ERRORS.none? { |error| attributes.key?(error) } ? new(deeplinks: attributes) : Error.new(attributes)
    end
  end
end
