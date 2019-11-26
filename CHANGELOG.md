Workarea Checkoutdotcom 1.2.0 (2019-11-26)
--------------------------------------------------------------------------------

*   Move credit card tokenization to post transaction

    Checkout.com charges for every authorization transaction. Moving tokenzation to post
    transaction helps reduce the extra cost for the merchant.

    CHECKOUTDOTCOM-1
    Jeff Yucis

*   RuboCop Corrections

    Tom Scott

*   Add CI and Contribution Guidelines

    Tom Scott

*   Add Refund Tests from Workarea

    This was originally included upstream, but are typically skipped by
    plugins and applications. CheckoutDotCom is the only plugin that needs
    the unmodified tests from base, so copy those tests into the plugin
    since they are removed from base in v3.5+.
    Tom Scott

*   Update payment integration to use payment sources.

    CHKOUTCOM-3
    Jeff Yucis

*   Integrate checkout.com for credit card processing.

    CHKOUTCOM-1
    Jeff Yucis



Workarea Checkoutdotcom 1.1.0 (2019-08-06)
--------------------------------------------------------------------------------

*   Update payment integration to use payment sources.

    CHKOUTCOM-3
    Jeff Yucis



Workarea Checkoutdotcom 1.0.0 (2019-03-19)
--------------------------------------------------------------------------------

*   Integrate checkout.com for credit card processing.

    CHKOUTCOM-1
    Jeff Yucis



