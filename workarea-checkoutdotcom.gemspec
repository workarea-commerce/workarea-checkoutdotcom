$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workarea/checkoutdotcom/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workarea-checkoutdotcom"
  s.version     = Workarea::Checkoutdotcom::VERSION
  s.authors     = ["Jeff Yucis"]
  s.email       = ["jyucis@weblinc.com"]
  s.homepage    = "https://homebase.weblinc.com"
  s.summary     = "Checkout.com payment processor."
  s.description = "Checkout.com payment integration."

  s.files = `git ls-files`.split("\n")

  s.add_dependency 'workarea', '~> 3.x', '>= 3.5.x'
end
