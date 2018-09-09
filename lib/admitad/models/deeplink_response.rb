module Admitad
  class DeeplinkResponse < Success
    attribute :deeplinks, Array[String]
  end
end
