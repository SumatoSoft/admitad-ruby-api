module Admitad
  module Constants
    SCOPES = %i[
      public_data
      websites
      manage_websites
      advcampaigns
      advcampaigns_for_website
      manage_advcampaigns
      banners
      landings
      banners_for_website
      payments
      manage_payments
      announcements
      referrals
      coupons
      coupons_for_website
      private_data
      tickets
      manage_tickets
      private_data_email
      private_data_phone
      private_data_balance
      validate_links
      deeplink_generator
      statistics
      opt_codes
      manage_opt_codes
      webmaster_retag
      manage_webmaster_retag
      broken_links
      manage_broken_links
      lost_orders
      manage_lost_orders
      broker_application
      manage_broker_application
    ].freeze

    BASE_URI = 'https://api.admitad.com'.freeze

    STATISTIC_ACTIONS_PARAMS = %i[
      offset
      limit
      date_start
      date_end
      closing_date_start
      closing_date_end
      status_updated_start
      status_updated_end
      website
      campaign
      subid
      subid1
      subid2
      subid3
      subid4
      source
      status
      keyword
      action
      action_id
      banner
      action_type
      processed
      paid
      total
      order_by
    ].freeze

    BASE_PARAMS = %i[offset limit].freeze

    AFFILIATE_PROGRAMS_PARAMS = %i[offset limit language website has_tool traffic_id connection_status].freeze

    AD_SPACE_PARAMS = %i[offset limit status campaign_status access_token id].freeze

    BUFFER_TIME = 10

    ERRORS = %w[error_description error_code error].freeze
  end
end
