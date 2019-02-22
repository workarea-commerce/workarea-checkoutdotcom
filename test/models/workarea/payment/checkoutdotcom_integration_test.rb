require 'test_helper'
if Workarea::VERSION::MAJOR == 3 && Workarea::VERSION::MINOR < 2

  module Workarea
    class CheckoutdotcomIntegrationTest < Workarea::TestCase
      include CheckoutdotcomGatewayVCRConfig

      def test_store_auth
        VCR.use_cassette 'checkoutdotcom/store_auth' do
          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'authorize')
          operation = Payment::Authorize::CreditCard.new(tender, transaction)
          operation.complete!

          assert(transaction.success?, 'expected transaction to be successful')
          transaction.save!

          assert(tender.token.present?)
          assert(tender.profile.gateway_id.present?)
        end
      end

      def test_store_purchase
        VCR.use_cassette 'checkoutdotcom/store_purchase' do

          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'purchase')
          operation = Payment::Purchase::CreditCard.new(tender, transaction)
          operation.complete!
          assert(transaction.success?)
          transaction.save!

          assert(tender.token.present?)
          assert(tender.profile.gateway_id.present?)
        end
      end

      def test_auth_capture
        VCR.use_cassette 'checkoutdotcom/auth_capture' do
          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'authorize')
          operation = Payment::Authorize::CreditCard.new(tender, transaction)
          operation.complete!
          assert(transaction.success?)
          transaction.save!

          assert(tender.token.present?)

          capture = Payment::Capture.new(payment: payment)
          capture.allocate_amounts!(total: 5.to_m)
          assert(capture.valid?)
          capture.complete!

          capture_transaction = payment.transactions.detect(&:captures)
          assert(capture_transaction.valid?)
        end
      end

      def test_auth_void
        VCR.use_cassette 'checkoutdotcom/auth_void' do
          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'authorize')
          operation = Payment::Authorize::CreditCard.new(tender, transaction)
          operation.complete!
          assert(transaction.success?, 'expected transaction to be successful')
          transaction.save!

          assert(tender.token.present?)

          operation.cancel!
          void = transaction.cancellation

          assert(void.success?)
        end
      end

      def test_purchase_void
        skip 'Voiding a purchase operation is no supported'
      end

      def test_auth_capture_refund
        VCR.use_cassette 'checkoutdotcom/auth_capture_refund' do
          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'authorize')
          operation = Payment::Authorize::CreditCard.new(tender, transaction)
          operation.complete!
          assert(transaction.success?, 'expected transaction to be successful')
          transaction.save!

          assert(tender.token.present?)

          capture = Payment::Capture.new(payment: payment)
          capture.allocate_amounts!(total: 5.to_m)
          assert(capture.valid?)
          capture.complete!

          capture_transaction = payment.transactions.detect(&:captures)
          assert(capture_transaction.valid?)

          refund = Payment::Refund.new(payment: payment)
          refund.allocate_amounts!(total: 5.to_m)

          assert(refund.valid?)
          refund.complete!

          refund_transaction = payment.credit_card.transactions.refunds.first
          assert(refund_transaction.valid?)
        end
      end

      def test_purchase_refund
        VCR.use_cassette 'checkoutdotcom/purchase_refund' do
          tender.amount = 5.to_m
          transaction = tender.build_transaction(action: 'purchase')
          operation = Payment::Purchase::CreditCard.new(tender, transaction)
          operation.complete!
          assert(transaction.success?)
          transaction.save!

          assert(tender.token.present?)

          refund = Payment::Refund.new(payment: payment)
          refund.allocate_amounts!(total: 5.to_m)

          assert(refund.valid?)
          refund.complete!

          refund_transaction = payment.credit_card.transactions.refunds.first
          assert(refund_transaction.valid?)
        end
      end

      private

        def gateway
          Workarea.config.gateways.credit_card
        end

        def payment
          @payment ||=
            begin
              order = create_order
              profile = create_payment_profile
              create_payment(
                id: order.id,
                profile_id: profile.id,
                address: {
                  first_name: 'Ben',
                  last_name: 'Crouse',
                  street: '22 s. 3rd st.',
                  city: 'Philadelphia',
                  region: 'PA',
                  postal_code: '19106',
                  country: Country['US']
                }
              )
            end
        end

        def tender
          @tender ||=
            begin
              payment.set_address(first_name: 'Ben', last_name: 'Crouse')

              payment.build_credit_card(
                number: 4242424242424242,
                month: 1,
                year: Time.current.year + 1,
                cvv: 100
              )

              payment.credit_card
            end
        end

        def order
          @order = create_order(payment.id)
        end
    end
  end
end
