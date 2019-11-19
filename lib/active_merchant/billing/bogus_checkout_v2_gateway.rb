# frozen_string_literal: true

module ActiveMerchant
  module Billing
    class BogusCheckoutV2Gateway < BogusGateway
      def verify(paysource, options = {})
        case normalize(paysource)
        when /1$/
          Response.new(true, SUCCESS_MESSAGE, { "source" => { "id" => "111", "customerId" => "cust_123" } }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

      def authorize_swipe(money, paysource, options = {})
        money = amount(money)
        case normalize(paysource)
        when /1$/, AUTHORIZATION
          Response.new(true, SUCCESS_MESSAGE, { "source" => { "id" => "111", "customerId" => "cust_123" }, "authorized_amount" => money }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { authorized_amount: money, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end

      def purchase_swipe(money, paysource, options = {})
        money = amount(money)
        case normalize(paysource)
        when /1$/, AUTHORIZATION
          Response.new(true, SUCCESS_MESSAGE, { "source" => { "id" => "111", "customerId" => "cust_123" }, "paid_amount" => money }, test: true, authorization: AUTHORIZATION)
        when /2$/
          Response.new(false, FAILURE_MESSAGE, { paid_amount: money, error: FAILURE_MESSAGE }, test: true, error_code: STANDARD_ERROR_CODE[:processing_error])
        else
          raise Error, error_message(paysource)
        end
      end
    end
  end
end
