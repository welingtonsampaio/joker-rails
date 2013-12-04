require 'mustache'
require 'pundit'
require 'devise'
require 'devise/orm/active_record'

module Joker
  module Rails
    VENDOR_PATH      = File.expand_path("../../../vendor/assets", __FILE__)
    SPEC_PATH        = File.expand_path("../../../spec", __FILE__)
    ROUTES_PATH      = File.expand_path("../../../config/routes.rb", __FILE__)
    JOKER_RAILS_PATH = File.expand_path("../rails", __FILE__)


    autoload :Filter, 'joker/rails/filter'
    autoload :FilterMustache, 'joker/rails/filter/mustache'

    module ActionController
      autoload :Base, 'joker/rails/action_controller/base'
    end

    module ActionView
      autoload :Helpers, 'joker/rails/action_view/helpers'
    end

    module Concerns
      autoload :DefaultValue, 'joker/rails/concerns/default_value'
      autoload :Filter,       'joker/rails/concerns/filter'
    end
  end
end

require 'joker/rails/engine' if ::Rails.version >= '3.1'
require 'joker/rails/railtie'
require "joker/rails/version"
