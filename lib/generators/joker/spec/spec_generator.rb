module Joker
  module Generators
    class SpecGenerator < ::Rails::Generators::Base

      desc <<DESC
Description:
    Configuration Konacha for generate spec to jokerJS.
DESC

      def self.source_root
        File.expand_path(File.dirname(__FILE__))
      end

      def add_gem_konacha
        gem_group :development, :test do
          gem 'konacha'
          gem 'selenium-webdriver'
        end
      end

      def create_initializer_konacha
        initializer "konacha.rb", get_konacha_template
      end

      def post_install
        readme 'POST_INSTALL'
      end

      private

      def get_konacha_template
        <<TEMPLATE
if defined?(Konacha)
  Konacha.configure do |config|
    config.spec_dir     = Pathname.new("#{File.expand_path(Joker::Rails::SPEC_PATH)}/javascripts").relative_path_from Rails.root
  end
end
TEMPLATE
      end
    end
  end
end