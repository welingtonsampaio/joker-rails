# Used to ensure that Rails 3.0.x, as well as Rails >= 3.1 with asset pipeline disabled
# get the minified version of the scripts included into the layout in production.
module Joker
  module Rails
    class Railtie < ::Rails::Railtie
      #paths["config/routes"].prepend Joker::Rails::ROUTES_PATH
      initializer "JokerRails.railtie" do |app|
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/images"
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/javascripts"
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/stylesheets"
      end
    end
  end
end