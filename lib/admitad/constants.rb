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

    BASE_URI   = 'https://api.admitad.com'.freeze
    GRANT_TYPE = 'client_credentials'.freeze
  end
end
