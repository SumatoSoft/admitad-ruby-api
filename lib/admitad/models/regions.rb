module Admitad
  class Regions < Success
    attribute :results, Array

    alias value results

    class << self
      def where(**params)
        create(Wrapper.regions(params))
      end

      def all
        where
      end
    end
  end
end
