# Used to ensure that Rails 3.0.x, as well as Rails >= 3.1 with asset pipeline disabled
# get the minified version of the scripts included into the layout in production.
require 'joker/rails'
require 'rails'
module Joker
  module Rails
    class Railtie < ::Rails::Railtie
      #paths["config/routes"].prepend Joker::Rails::ROUTES_PATH
      initializer "JokerRails.railtie" do |app|
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/images"
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/javascripts"
        app.assets.prepend_path "#{Joker::Rails::VENDOR_PATH}/stylesheets"
      end

      initializer "joker_rails.active_record" do
        ActiveSupport.on_load :active_record do
          require 'joker/rails/active_record'
        end
      end

      initializer "joker_rails.view_helpers" do
        ::ActionView::Base.send :include, Joker::Rails::ActionView::Helpers
      end
    end
  end
end