
module Joker
  module Rails
    VENDOR_PATH = File.expand_path("../../../vendor/assets", __FILE__)
    SPEC_PATH   = File.expand_path("../../../spec", __FILE__)
    ROUTES_PATH = File.expand_path("../../../config/routes.rb", __FILE__)
  end
end
require 'joker/rails/engine' if ::Rails.version >= '3.1'
require 'joker/rails/railtie'
require "joker/rails/version"
