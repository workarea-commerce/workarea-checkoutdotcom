module Workarea
  module CheckoutdotcomGatewayVCRConfig
    def self.included(test)
      super
      test.setup :setup_gateway
      test.teardown :reset_gateway
    end

    def setup_gateway
      @_old_gateway = Workarea.config.gateways.credit_card
      Workarea.config.gateways.credit_card = ActiveMerchant::Billing::CheckoutV2Gateway.new(
        secret_key: 'sk_test_f4c1d728-928c-4381-bc6b-03c0888fb877'
      )
    end

    def reset_gateway
      Workarea.config.gateways.credit_card = @_old_gateway
    end
  end
end
