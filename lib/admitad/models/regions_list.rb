module Admitad
  class RegionsList < Success
    attribute :results, Array

    alias value results
  end
end
