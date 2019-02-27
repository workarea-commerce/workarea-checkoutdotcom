require 'workarea'
require 'workarea/storefront'
require 'workarea/admin'

require 'workarea/checkoutdotcom/engine'
require 'workarea/checkoutdotcom/version'

require 'active_merchant/billing/bogus_checkout_v2_gateway'

module Workarea
  module Checkoutdotcom
    # Credentials for checkoutdotcom from Rails secrets.
    #
    # @return [Hash]
    def self.credentials
      return {} unless Rails.application.secrets.checkoutdotcom.present?
      Rails.application.secrets.checkoutdotcom.symbolize_keys
    end

    # Conditionally use the real gateway when secrets are present.
    # Otherwise, use the bogus gateway.
    #
    # @return [ActiveMerchant::Billing::Gateway]
    def self.gateway
      Workarea.config.gateways.credit_card
    end

    def self.gateway=(gateway)
      Workarea.config.gateways.credit_card = gateway
    end

    def self.auto_initialize_gateway
      if credentials.present?
        if ENV['HTTP_PROXY'].present?
          uri = URI.parse(ENV['HTTP_PROXY'])
          ActiveMerchant::Billing::CheckoutV2Gateway.proxy_address = uri.host
          ActiveMerchant::Billing::CheckoutV2Gateway.proxy_port = uri.port
        end

        self.gateway = ActiveMerchant::Billing::CheckoutV2Gateway.new credentials
      else
        self.gateway = ActiveMerchant::Billing::BogusCheckoutV2Gateway.new
      end
    end
  end
end
