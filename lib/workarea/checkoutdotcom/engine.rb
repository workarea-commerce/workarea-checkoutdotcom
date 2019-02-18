module Workarea
  module Checkoutdotcom
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::Checkoutdotcom
    end
  end
end
