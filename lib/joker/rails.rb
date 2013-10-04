
module Joker
  module Rails
    VENDOR_PATH = File.expand_path("../../../vendor/assets", __FILE__)
    SPEC_PATH   = File.expand_path("../../../spec", __FILE__)
    ROUTES_PATH = File.expand_path("../../../config/routes.rb", __FILE__)

    module ActionController
      autoload :Base, 'joker/rails/action_controller/base'
    end

    module ActionView
      autoload :Helpers, 'joker/rails/action_view/helpers'
    end
  end
end

require 'joker/rails/engine' if ::Rails.version >= '3.1'
require 'joker/rails/railtie'
require "joker/rails/version"
