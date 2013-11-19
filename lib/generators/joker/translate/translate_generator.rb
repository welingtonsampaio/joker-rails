module Joker
  module Generators
    class TranslateGenerator < ::Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create a ScaffoldController to the model used in JokerJS.
DESC

      def inserting_model_translate
        I18n.available_locales.each do |locale|
          @locale = locale
          template 'models.yml', "config/locales/#{locale}/models.yml" unless File.exist? "config/locales/#{locale}/models.yml"
          append_to_file "config/locales/#{locale}/models.yml",
                         "\n      #{singular_table_name}: #{human_name}" \
                         "\n      #{plural_table_name}: #{human_name.pluralize}"
        end
      end

      def create_attribute_translate
        I18n.available_locales.each do |locale|
          @locale = locale
          template "model.yml", "config/locales/#{locale}/models/#{plural_table_name}.yml"
        end
      end
    end
  end
end