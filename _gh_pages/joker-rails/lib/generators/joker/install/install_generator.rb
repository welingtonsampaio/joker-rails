module Joker
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      #argument :attributes, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"
      source_root File.expand_path("../templates", __FILE__)

      desc <<DESC
Description:
    Create all necessary files for Joker operation.
DESC

      def config_file
        config_file_path = 'config/application.rb'
        uncomment_lines config_file_path, /config\.i18n\.default_locale/
        uncomment_lines config_file_path, /config\.i18n\.load_path/
        gsub_file       config_file_path, 'config.i18n.default_locale', 'config.i18n.default_locale = :en #'
        gsub_file       config_file_path, %/Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]/, %/Dir[Rails.root.join('config','locales', '**', '*.{rb,yml}').to_s]/
      end

      def create_locales
        I18n.available_locales.each do |locale|
          @locale = locale
          template "models.yml", "config/locales/#{locale}/models.yml"
        end
      end

      def create_javascripts
        create_file 'app/assets/javascripts/app/controllers/.keep'
        create_file 'app/assets/javascripts/app/support/.keep'
        template 'app.coffee', 'app/assets/javascripts/app.coffee'
        template 'joker_init.coffee', 'app/assets/javascripts/joker_init.coffee'
        template 'routes.txt', 'app/assets/javascripts/app/routes.coffee.erb'
        remove_file 'app/assets/javascripts/application.coffee' if File.exist? 'app/assets/javascripts/application.coffee'
        remove_file 'app/assets/javascripts/application.js'     if File.exist? 'app/assets/javascripts/application.js'
        template 'application.coffee', 'app/assets/javascripts/application.coffee'
        if File.exist? 'app/views/layouts/application.html.erb'
          inject_into_file 'app/views/layouts/application.html.erb', before: '</body>' do
            "  <script type='text/javascript'>\n" \
            "    Joker.bootstrap()\n" \
            "  </script>\n"
          end
        end
      end

      def create_scss
        template 'containers.scss', 'app/assets/stylesheets/app/_containers.scss'
        remove_file 'app/assets/stylesheets/application.scss'     if File.exist? 'app/assets/stylesheets/application.scss'
        remove_file 'app/assets/stylesheets/application.css.scss' if File.exist? 'app/assets/stylesheets/application.css.scss'
        remove_file 'app/assets/stylesheets/application.css'      if File.exist? 'app/assets/stylesheets/application.css'
        template 'application.scss', 'app/assets/stylesheets/application.scss'
        template 'app.scss', 'app/assets/stylesheets/app.scss'
        copy_file ::Joker::Rails::VENDOR_PATH + "/stylesheets/joker/_variables.scss", 'app/assets/stylesheets/_joker_variables.scss'
        gsub_file 'app/assets/stylesheets/_joker_variables.scss', / !default/, ''
        gsub_file 'app/assets/stylesheets/_joker_variables.scss', /^\$/, '// $'
      end

      def create_fonts
        copy_file 'icomoon.dev.svg', 'public/assets/icomoon.dev.svg'
        copy_file 'icomoon.eot', 'public/assets/icomoon.eot'
        copy_file 'icomoon.svg', 'public/assets/icomoon.svg'
        copy_file 'icomoon.ttf', 'public/assets/icomoon.ttf'
        copy_file 'icomoon.woff', 'public/assets/icomoon.woff'
      end

      def application_controller
        gsub_file 'app/controllers/application_controller.rb', ' ActionController::Base', ' Joker::Rails::ActionController::Base'
      end

    end
  end
end