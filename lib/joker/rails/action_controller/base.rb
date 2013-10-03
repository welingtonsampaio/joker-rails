module Joker::Rails
  module ActionController
    class Base < ::ActionController::Base
      layout :set_default_to_js_format

      def set_default_to_js_format
        "content_only" if params[:format] == "js"
      end
    end
  end
end