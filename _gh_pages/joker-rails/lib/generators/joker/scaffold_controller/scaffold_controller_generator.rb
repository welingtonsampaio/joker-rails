module Joker
  module Generators
    class ScaffoldControllerGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create a ScaffoldController to the model used in JokerJS.
DESC

      def create_controller
        template "controller.erb", "app/controllers/#{plural_table_name}_controller.rb"
      end
    end
  end
end