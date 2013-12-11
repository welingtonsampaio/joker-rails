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
        template "edit.html.erb", "app/views/#{plural_table_name}/edit.html.erb"
        template "new.html.erb", "app/views/#{plural_table_name}/new.html.erb"
        template "show.html.erb", "app/views/#{plural_table_name}/show.html.erb"
      end

      def create_partials
        template "_menu.html.erb", "app/views/#{plural_table_name}/_menu.html.erb"
        template "_tbody.html.erb", "app/views/#{plural_table_name}/_tbody.html.erb"
        template "_form.html.erb", "app/views/#{plural_table_name}/_form.html.erb"
      end

      def create_json_views
        template "index.json.rabl", "app/views/#{plural_table_name}/index.json.rabl"
        template "show.json.rabl", "app/views/#{plural_table_name}/show.json.rabl"
      end

    end
  end
end