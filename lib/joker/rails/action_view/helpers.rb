module Joker::Rails
  module ActionView
    module Helpers

      ##
      #
      #
      def window_create(title='', name = nil, uri = nil, html_options = nil, &block)
        default = {
            data: {
                jrender_title: title,
                jwindow: true
            }
        }
        if block_given?
          uri = default.merge uri || {}
        else
          html_options = default.merge html_options || {}
        end
        link_to name, uri, html_options, &block
      end
    end
  end
end