module Admitad
  module Currencies
    class Currency < Success
      attribute :code, String
      attribute :min_sum, String
      attribute :name, String
      attribute :sign, String

      class << self
        def where(**params)
          Response.create(Wrapper.currencies(params))
        end

        def all
          where
        end
      end
    end

    class Rate < Success
      attribute :base, String
      attribute :target, String
      attribute :date, String
      attribute :rate, String

      class << self
        def find(**params)
          create(Wrapper.currencies_rate(params))
        end
      end
    end

    class Response < Success
      attribute :results, Array[Currency]
      attribute :_meta, Hash

      alias currencies results
      alias metadata _meta
    end
  end
end
