module Admitad
  class Regions < Success
    attribute :results, Array
    attribute :_meta, Hash

    alias regions results
    alias metadata _meta

    class << self
      def where(**params)
        create(Wrapper.regions(params))
      end
    end
  end
end
