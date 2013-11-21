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

      ##
      #
      #
      def render_filters model
        puts model.new.get_filters
      end

      # Render the controller menu in all of its actions. The menu file should be included inside it's controller folder
      # for views.
      def render_menu
        render "#{controller_name}/menu" if File.exist? File.expand_path(Rails.root.join "app", "views",controller_name,"_menu.html.erb") unless params[:content_only].present?
      end

      # Create a tag for Buy Order Status
      def status_tag(status)
        "<span class='label label-#{status.to_s}'>#{t("status.#{status.to_s}").humanize.upcase}</span>".html_safe
      end

      def translate_attribute(model, attribute)
        model.human_attribute_name(attribute)
      end
      alias_method :ta, :translate_attribute

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

          ::ActionView::Helpers::Tags::TextField.new(:typehead, method, self, options).render +
          ::ActionView::Helpers::Tags::HiddenField.new(@object_name, method, self, original_options).render
        end
      end
    end

  end
end