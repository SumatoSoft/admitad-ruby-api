module Admitad
  class Position < Success
    attribute :id, Integer
    attribute :tariff_id, Integer
    attribute :datetime, DateTime
    attribute :amount, String
    attribute :payment, String
    attribute :rate, String
    attribute :product_url, String
    attribute :product_id, Integer
    attribute :product_name, String
    attribute :product_image, String
    attribute :percentage, String
  end

  class Action < Success
    attribute :action_id, Integer
    attribute :advcampaign_name, String
    attribute :advcampaign_id, Integer
    attribute :website_name, String
    attribute :status, String
    attribute :comment, String
    attribute :action_date, DateTime
    attribute :action_type, String
    attribute :payment, String
    attribute :action, String
    attribute :tariff_id, Integer
    attribute :currency, String
    attribute :conversion_time, Integer
    attribute :keyword, String
    attribute :cart, String
    attribute :subid, Integer
    attribute :subid1, Integer
    attribute :subid2, Integer
    attribute :subid3, Integer
    attribute :subid4, Integer
    attribute :click_date, DateTime
    attribute :click_user_referer, String
    attribute :banner_id, Integer
    attribute :closing_date, DateTime
    attribute :status_updated, DateTime
    attribute :processed, Integer
    attribute :paid, Integer
    attribute :order_id, Integer
    attribute :positions, Array[Admitad::Position]
  end

  class ActionsResponse < Success
    attribute :results, Array[Admitad::Action]
    attribute :_meta, Hash

    alias actions results
    alias metadata _meta
  end
end
