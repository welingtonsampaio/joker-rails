module Joker
  module Generators
    class ScaffoldGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"

      desc <<DESC
Description:
    Create a Scaffold for the model used in JokerJS. Controller, Model, View, Javascript
DESC

      def create_controller
        invoke 'joker:scaffold_controller', [class_name,  get_attributes ]
      end

      def create_views
        invoke 'joker:views', [class_name, get_attributes ]
      end

      def create_model
        invoke :migration, ["create_#{plural_table_name}", get_attributes ]
      end

      protected

      def get_attributes
        attributes.collect { |i| "#{i.name}:#{i.type}#{ i.has_index? ? ':index' : '' }" }
      end

    end
  end
end