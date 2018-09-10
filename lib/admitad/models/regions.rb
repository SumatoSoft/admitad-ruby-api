module Admitad
  class Regions < Success
    attribute :results, Array

    alias value results

    def self.where(**params)
      create(Wrapper.regions(params))
    end
  end
end
