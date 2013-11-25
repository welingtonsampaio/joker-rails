module Joker
  module Generators
    class ModelGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create Model used in JokerJS.
DESC

      def create_model
        invoke :model, [class_name, get_attributes ]
      end

      def remove_default_model
        remove_file "app/models/#{singular_table_name}.rb"
      end

      def template_model
        template 'model.txt', "app/models/#{singular_table_name}.rb"
      end

      def append_to_js_route
        append_to_file 'app/assets/javascripts/app/routes.coffee.erb' do
          "  #{plural_table_name}_filter_path: -> '<%= #{plural_table_name}_path %>'\n" \
          "  #{plural_table_name}_path: -> '<%= #{plural_table_name}_path :json %>'"
        end
      end

      protected
      def check_status_exists?
        attributes_names.include? 'status'
      end

      def get_attributes
        attributes.collect { |i| "#{i.name}:#{i.type}#{ i.has_index? ? ':index' : '' }" }
      end
    end
  end
end