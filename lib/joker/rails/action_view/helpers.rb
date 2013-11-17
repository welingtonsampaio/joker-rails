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

      ##
      #
      #
      def render_to(destination='', name = nil, uri = nil, html_options = nil, &block)
        default = {
            data: {
                jrender: destination
            }
        }
        if block_given?
          uri = default.merge uri || {}
        else
          html_options = default.merge html_options || {}
        end
        link_to name, uri, html_options, &block
      end

      module FormBuilder
        include ::ActionView::Helpers::CaptureHelper
        def typeahead( url_consulting, method,  options = {} )
          original_options = options.clone

          options = {
            data: {
              autocomplete: url_consulting,
              target: [@object_name, method].join('_'),
              valuekey: "name",
              indicekey: "id"
            },
            class: ''
          }.deep_merge options
          options[:class] += ' typeahead'
          options[:value] = @object.send(method[0..-4]).send options[:data][:valuekey] if @object.persisted?
          original_options[:value] = @object.send(method) if @object.persisted?

          "<div>".html_safe +
          ::ActionView::Helpers::Tags::TextField.new(:typehead, method, self, options).render +
          ::ActionView::Helpers::Tags::HiddenField.new(@object_name, method, self, original_options).render +
          "</div>".html_safe
        end
      end
    end

  end
end