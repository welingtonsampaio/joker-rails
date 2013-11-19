module Joker
  module Generators
    class JsControllerGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create Views used in JokerJS.
DESC

      def create_js_controller
        template "model_controller.coffee", "app/assets/javascripts/app/controllers/#{singular_table_name}_controller.coffee"
      end

    end
  end
end