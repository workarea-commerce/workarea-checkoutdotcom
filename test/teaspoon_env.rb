require 'workarea/testing/teaspoon'

Teaspoon.configure do |config|
  config.root = Workarea::Checkoutdotcom::Engine.root
  Workarea::Teaspoon.apply(config)
end
