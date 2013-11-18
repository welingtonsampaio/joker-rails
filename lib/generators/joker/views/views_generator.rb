module Joker
  module Generators
    class ViewsGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create Views used in JokerJS.
DESC

      def create_views
        template "index.html.erb", "app/views/#{plural_table_name}/index.html.erb"
      end

      def create_partials
        template "_menu.html.erb", "app/views/#{plural_table_name}/_menu.html.erb"
      end

      def create_json_views

      end

    end
  end
end