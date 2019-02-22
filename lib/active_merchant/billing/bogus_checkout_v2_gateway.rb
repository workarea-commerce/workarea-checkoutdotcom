# frozen_string_literal: true

module ActiveMerchant
  module Billing
    class BogusCheckoutV2Gateway < BogusGateway

      def verify(paysource, options = {})
        case normalize(paysource)
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, { "card" => { "id" => "111", "customerId" => "cust_123" } }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

    end
  end
end
