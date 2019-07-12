Workarea Checkout.com Payment Processor
================================================================================

Checkout.com payment processor integration for credit cards.

The plugin supports:

1. Tokenization
2. Authorization
3. Purchase (auth with capture)
4. Refund

Tokenization is done via a $0 dollar authorization, be sure to check that this is allowed by the financial institution being used by Checkout.com


Installation
--------------------------------------------------------------------------------

Testing accounts can be created for free at https://www.checkout.com/

Once an account is provisioned the secret key will need to be installed into the host applications secrets file:

    checkoutdotcom:
      secret_key: sk_test_XXXXXXX

The secret key can be found in the **Channels** tab in the **Settings** section of the Checkout.com hub.

Test environments must use the pre-defined test cards for successful transactions. See more information about testing here: https://docs.checkout.com/docs/testing

Getting Started
--------------------------------------------------------------------------------

This gem contains a rails engine that must be mounted onto a host Rails application.

To access Workarea gems and source code, you must be an employee of WebLinc or a licensed retailer or partner.

Workarea gems are hosted privately at https://gems.weblinc.com/.
You must have individual or team credentials to install gems from this server. Add your gems server credentials to Bundler:

    bundle config gems.weblinc.com my_username:my_password

Or set the appropriate environment variable in a shell startup file:

    export BUNDLE_GEMS__WEBLINC__COM='my_username:my_password'

Then add the gem to your application's Gemfile specifying the source:

    # ...
    gem 'workarea-checkoutdotcom', source: 'https://gems.weblinc.com'
    # ...

Or use a source block:

    # ...
    source 'https://gems.weblinc.com' do
      gem 'workarea-checkoutdotcom'
    end
    # ...

Update your application's bundle.

    cd path/to/application
    bundle

Workarea Platform Documentation
--------------------------------------------------------------------------------

See [http://developer.weblinc.com](http://developer.weblinc.com) for Workarea platform documentation.

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright WebLinc 2019. All rights reserved.

For licensing, contact sales@workarea.com.
