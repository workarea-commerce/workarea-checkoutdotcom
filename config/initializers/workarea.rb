Workarea.configure do |config|
  config.run_credit_card_refund_tests = true
end

Workarea::Checkoutdotcom.auto_initialize_gateway
