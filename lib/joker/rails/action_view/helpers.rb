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

      # Render the controller menu in all of its actions. The menu file should be included inside it's controller folder
      # for views.
      def render_menu
        render partial: "#{controller_name}/menu" unless params[:content_only].present?
      end

      # Create a tag for Buy Order Status
      def status_tag(status)
        "<span class='label label-#{status.to_s}'>#{t("status.#{status.to_s}").humanize.upcase}</span>".html_safe
      end

      #
      #
      def tab_form(parent, &block)
        content_tag :div, {:class => 'tabs-container', :data => {:parent => parent}}, &block
      end

      #
      #
      def tab_for(icon, text, &block)
        content_tag :div, {:class => 'tab', :data => {:tab_icon => icon, :tab_text => text}}, &block
      end

      # Renderiza na tela formulários que possuem a possibilidade de inserir multiplos campos,
      # como formulário de telefone, produtos de uma nota fiscal, etc.
      #
      #
      # @param collection <ActiveRecord::Relation>
      # @param wrapper <String>
      # @param options <Hash>
      #
      # Existem algumas regras que devem ser utilizadas na criação de um template. Cada container
      # de um item deve possuir um id especificado pela tag {uniq_reference}
      #
      #-------------------------------------------------------------------------------------------
      # Tags que podem ser utilizadas no template
      #-------------------------------------------------------------------------------------------
      #
      # {uniq_id} : Gera um ID unico para ser utilizado
      # {uniq_reference} : Gera uma referencia unica para o container gerado
      # {select_XXX} : Gera um campo select, substituir XXX pelo nome (separado por _) da selection
      #                passada nas options
      # {entry.param} : Imprime o valor de uma propriedade da collection especificada em option
      #                 Param é o nome da propriedade que deseja ser impressa
      #
      #
      #
      # Exemplo de configuração do Hash de opções:
      #
      #options = {
      #    :template => %q[
      #      <div class="row-fluid" id="{uniq_reference}">
      #      <div class="span4">
      #        <label for="contact_type_{uniq_id}">Tipo de Contato</label>
      #        {select_contact_type}
      #      </div>
      #      <div class="span7">
      #        <label for="contact_{uniq_id}">Contato</label>
      #        <input class="input-block-level" type="text" name="contact[{entry.id}][contact]"
      #               id="contact_{uniq_id}" value="{entry.contact}"/>
      #        <input type="hidden" name="contact[{entry.id}][id]" value="{entry.id}"/>
      #      </div>
      #      <div class="span1">
      #        {remove_tag[iconset1-remove-sign]}
      #      </div>
      #    </div>
      #    ],
      #    :selections => {
      #        :contact_type => {
      #            :collection => ContactType.all.collect { |v| [v.id, v.name] },
      #            :id => "contact_type_{uniq_id}",
      #            :name => "contact[{entry.id}][contact_type_id]",
      #            :class => "input-block-level chosen-select"
      #        }
      #    },
      #    :callbacks => {
      #        :after_blur => '.class',
      #        :after_button_press => {:text => "Inserir novo Contato", :trigger => 'add-contact'}
      #    }
      #}
      def multiple_fields_for(collection, wrapper, options)
        str = options[:template]
        options[:selections].each do |key,value|
          target = key
          select_string = "<select name='#{value[:name]}' id='#{value[:id]}' class='#{value[:class]}'>"
          value[:collection].each{|i| select_string += "<option #{key}value='#{i[0]}'>#{i[1]}</option>"}
          select_string += '</select>'
          str.gsub! "{select_#{target}}", select_string
        end
        callbacks = Hash.new
        (options[:callbacks] || {}).each { |key,value| callbacks["callbacks_#{key}"] = value }
        response = content_tag :div, {:class => "#{wrapper} multiple-fields-wrapper", :data =>{
            :template => str,
            :callbacks => options[:callbacks] || {},
            :wrapper => wrapper,
            :remove_icon => str.match(/.{remove_tag\[(...*)\]}/im)[1]
        }} do
          content = ""
          collection.each do |entry|
            str_dup = str.dup
            uniq_id = SecureRandom.hex 10
            uniq_reference = SecureRandom.hex 20
            str_dup.gsub! '{uniq_id}', uniq_id
            str_dup.gsub! '{uniq_reference}', uniq_reference
            need_replace = str.scan /\{entry.(\w*)\}/i
            need_replace.each{|s| str_dup.gsub!("{entry.#{s[0]}}", entry.send(s[0]).to_s)}
            options[:selections].each do |key,value|
              str_dup.gsub!( "#{key}value='#{entry.send("#{key}_#{entry.send(key).class.send :primary_key}")}'", "#{key}value='#{entry.send("#{key}_#{entry.send(key).class.send :primary_key}")}' selected" )
              str_dup.gsub!( "#{key}value", "value" )
            end
            str_dup.gsub!(/{remove_tag\[(...*)\]}/im) {"<a href='#' class='remove-item'><i class='#{$1}' data-target='#{uniq_reference}'></i></a>"}
            content += str_dup
          end
          content.html_safe
        end
        if options.has_key? :callbacks
          callbacks = options[:callbacks]
          if callbacks.has_key? :after_button_press
            response += "<div class='row-fluid mmf-btn-wrapper'>".html_safe
            response += content_tag :button, {:class => "btn btn-small #{callbacks[:after_button_press][:trigger]}", :type => "button"} do
              "<i class='iconset1-plus'></i> #{callbacks[:after_button_press][:text]}".html_safe
            end
            response += "</div>".html_safe
          end
        end
        response.html_safe
      end
      alias_method :mff, :multiple_fields_for

      #
      #
      def joker_upload( upload )
        id = SecureRandom.hex
        content_tag :div, {id: id} do
          javascript_tag do
"new Joker.Uploader({
  container: '#{id}',
  url: '#{upload.url}',
  filters: {
    mime_types: #{upload.filters.to_s}
  },
  multipart_params: {
    '#{ request_forgery_protection_token }': '#{ form_authenticity_token }',
    '#{ Rails.application.config.session_options[:key] }': '#{ request.session_options[:id] }'
  },
  callbacks: #{upload.callbacks.to_json}
});".html_safe
          end
        end
      end

      #
      #
      def translate_attribute(model, attribute)
        model.human_attribute_name(attribute)
      end
      alias_method :ta, :translate_attribute

      #
      #
      def translate_joker
        locale_translate = I18n.backend.send(:translations)[I18n.locale]
        joker_translations = {}
        joker_translations.deep_merge! date: locale_translate[:date]
        joker_translations.deep_merge! models: (locale_translate[:activerecord][:models] || {}) if locale_translate[:activerecord].present?
        joker_translations.deep_merge! locale_translate[:joker] if locale_translate[:joker].present?
        joker_translations.deep_merge! locale_translate[:zerp] if locale_translate[:zerp].present?
        javascript_tag " Joker.I18n.translations = #{joker_translations.to_json}"
      rescue
        I18n.t :date
        translate_joker
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

          ::ActionView::Helpers::Tags::TextField.new(:typehead, method, self, options).render +
          ::ActionView::Helpers::Tags::HiddenField.new(@object_name, method, self, original_options).render
        end

        def joker_date( method, options={} )
          klasses = options[:class] || options['class'] || ''
          options = {
              data: {
                  date_field: {}
              },
              class: klasses.concat( ' date-field' )
          }.deep_merge options
          ::ActionView::Helpers::Tags::TextField.new(@object_name, method, self, options).render
        end

      end
    end

  end
end